{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE GADTs #-}

module VSim.Runtime.Monad where

import Control.Applicative
import Control.Monad.BP2 as BP
import Control.Monad.State.Strict
import Control.Monad.Reader
import Control.Monad.Identity
import Control.Monad.Trans
import Data.Monoid
import qualified Data.IntMap as IntMap
import Data.List as List
import Data.Map as Map
import Data.Range
import Data.IntMap as IntMap
import Data.Array2
import Data.Set as Set
import Data.HashMap.Lazy as HM
import Data.HashSet as HS
import Text.Printf

import System.IO.Unsafe (unsafePerformIO)

import VSim.Runtime.Class
import VSim.Runtime.Time
import VSim.Runtime.Ptr
import VSim.Runtime.Waveform

class (MonadPtr m) => MonadMem m where
    get_mem :: m Memory
    put_mem :: Memory -> m ()

instance (MonadPtr m) => MonadMem (StateT Memory m) where
    get_mem = get
    put_mem = put

instance (MonadMem m) => MonadMem (ReaderT s m) where
    get_mem = lift $ get_mem
    put_mem = lift . put_mem

instance (MonadMem m) => MonadMem (BP l e m) where
    get_mem = lift $ get_mem
    put_mem = lift . put_mem

modify_mem :: MonadMem m => (Memory -> Memory) -> m ()
modify_mem f = get_mem >>= \m -> put_mem (f m)

-- data Value t x = Value {-# UNPACK #-} !String {-# UNPACK #-} !t {-# UNPACK #-} !x
data Value t x = Value String t x
    deriving(Show)

vn (Value n _ _) = n
vt (Value _ t _) = t
vr (Value _ _ r) = r

-- | VHDL primitive type can are described with it's upper and lower bounds. Use
-- of Ints is a limitation of a current implementation.
-- data PrimitiveT t = PrimitiveT {-# UNPACK #-} !t {-# UNPACK #-} !t
data PrimitiveT t = PrimitiveT t t
    deriving(Show)

lower (PrimitiveT x _) = x
upper (PrimitiveT _ x) = x

ranged :: Int -> Int -> PrimitiveT Int
ranged a b = PrimitiveT a b

unranged :: PrimitiveT Int
unranged = PrimitiveT minBound maxBound

-- | VHDL variable (runtime representation)
newtype VarR t = VarR { vval :: t } deriving(Show)

-- instance (MonadPtr m) => Cloneable m (Ptr a) where
--     clone r = derefM r >>= allocM 

type Variable = Value (PrimitiveT Int) (Ptr (VarR Int))


type Processes = Set.Set (Ptr Process)

-- | VHDL primitive signal
data SigR t = SigR {
      swave :: Waveform t
    , sproc :: Processes
    , suniq :: Int
    } deriving(Show)

instance HasUniq (SigR t) where
    getUniq = suniq

type Signal t = Value (PrimitiveT t) (Ptr (SigR t))


-- | Don't know the degree it is safe up to. Probably, forcing strict evaluation
-- of signals in the timewheel is enough.
unsafeWaveform :: Signal t -> Waveform t
unsafeWaveform (Value _ _ r) = unsafePerformIO (swave <$> derefM r)

type Constant = Value (PrimitiveT Int) Int

signalUniqIq :: (MonadPtr m) => Signal Int -> m Int
signalUniqIq s = suniq <$> derefM (vr s)

in_range :: (Ord t) => (PrimitiveT t) -> t -> Bool
in_range (PrimitiveT l u) v = v >= l && v <= u

in_range_w :: (Ord t) => PrimitiveT t -> Waveform t -> Bool
in_range_w t w = and $ List.map f $ wchanges w where
    f (Change _ v) = in_range t v

instance (MonadPtr m, Show t, Ord t) => Constrained m (Signal t) where
    ccheck (Value n t r) = derefM r >>= \s -> do
        when (not $ in_range_w t (swave s)) $ do
            pfail3 "constrained failed: name %s type (%s) val (%s)" n (show t) (show (swave s))

instance (MonadPtr m) => Constrained m Variable where
    ccheck (Value n t r) = derefM r >>= \v -> ccfail_ifnot v (in_range t (vval v))

sigassign1 :: (MonadSim m) => AnyPrimitive Assignment -> m ()
sigassign1 (AnyPrimitive (Assignment v w')) = do
    updateM (\s -> s{swave = w'}) (vr v)
    ccheck v

sigassign2 :: (MonadSim m) => NextTime -> AnyPrimitiveSignal -> m Processes
sigassign2 t (AnyPrimitiveSignal v) = do
    s <- derefM (vr v)
    let (t',w') = event (swave s)
    case compare t t' of
        LT -> pfail3 "sigassign2: miss event: name %s time %s now %s"
                (show v) (show t') (show t)
        GT -> liftIO $ do
            putStrLn $ printf "sigassign2: early event: name %s" (show v)
            return (Set.empty)
        EQ -> do
            writeM (vr v) s{swave = w', sproc = Set.empty}
            return (sproc s)

-- | VHDL array type
data ArrayT t = ArrayT {
      -- | Type of elements
      aconstr :: t
      -- | The range
    , arange :: RangeT
    } deriving(Show)

-- VHDL arrays runtime part
type ArrayR a = Array2 a

-- | VHDL array entity
type Array t e = Value (ArrayT t) (ArrayR e)

-- | Assignment event, list of them is the result of process execution
data Assignment t = Assignment {
      -- | Signal to assign to
      acurr :: Signal t
      -- | New waveform for this signal
    , aswave :: Waveform t
    } deriving(Show)

-- | VHDL record type
newtype RecordT x = RecordT {
    rtype :: x
    } deriving(Show)

-- | VHDL records
data RecordR a = RecordR {
    rtuple :: a
    } deriving(Show)

type Accessor r f = (r -> f)

type Record t x = Value (RecordT t) (RecordR x)

now :: (MonadProc m) => m Time
now = ptime `liftM` get

type ProcessHandler = VProc () ()

-- | Representation of VHDL's process
data Process = Process {
      pname :: String
    -- ^ The name of a process
    , pstart :: ProcessHandler
    , pcont :: Either ProcessHandler ()
    -- ^ Returns newly-assigned signals
    -- , pawake :: Maybe NextTime
    -- , psignals :: [AnyPrimitiveSignal]
    , puniq :: Int
    -- ^ Unique identifier
    }

instance Show Process where
    show p = printf "Process { pname = \"%s\" }" (pname p)

instance HasUniq Process where
    getUniq = puniq

phandler :: Process -> ProcessHandler
phandler p = peek (pcont p) where
    peek (Left h) = h
    peek (Right ()) = pstart p

siglisten :: (MonadSim m) => Ptr Process -> [AnyPrimitiveSignal] -> m ()
siglisten r ss = do
    forM_ ss $ \(AnyPrimitiveSignal s) -> do
        flip updateM (vr s) $ \rs ->
            rs{ sproc = Set.insert r (sproc rs) }


debug s = liftIO . putStrLn $ "debug: " ++ s

data Memory = Memory {
      msignals :: IntMap [AnyPrimitiveSignal]
    , mprocesses :: Set.Set (Ptr Process)
    } deriving(Show)

noProcesses (Memory _ s) | Set.null s = True
                         | otherwise = False

emptyMem :: Memory
emptyMem = Memory IntMap.empty Set.empty

-- | Add the signal to memory.
addToMem :: (MonadPtr m, Show t) => Signal t -> Memory -> m Memory
addToMem s m = do
    u <- suniq <$> derefM (vr s)
    return m{ msignals = IntMap.insertWithKey
                           (\u s s' -> (s `mappend` s')) u
                           [AnyPrimitiveSignal s]
                           (msignals m) }

uniqSignals :: Memory -> [AnyPrimitiveSignal]
uniqSignals m = List.map (head . snd) (IntMap.toList (msignals m))

allSignals :: Memory -> [AnyPrimitiveSignal]
allSignals m = List.concat $ List.map snd $ IntMap.toList (msignals m) where

-- | Simulation step state
data SimStep = SimStep {
      ssp :: Set.Set (Ptr Process)
    , ssq :: Map.Map NextTime Event
    }
    deriving(Show)

start_step :: Memory -> (Time, SimStep)
start_step m = (minBound, SimStep (mprocesses m) (Map.empty))


{- VSim monad -}

data Severity = Low | High
    deriving(Show)

-- | A reason to pause the simulation
data Pause =
      Report Time Severity String
    | BreakHit Time Int
    deriving(Show)

data Event = Event [AnyPrimitiveSignal] Processes
    deriving(Show)

instance Monoid Event where
    mempty = Event mempty mempty
    mappend (Event [a] b) (Event a2 b2) = Event (a:a2) (b`mappend`b2)
    mappend (Event a b) (Event a2 b2) = Event (a`mappend`a2) (b`mappend`b2)

data VState = VState {
      vsmem :: Memory
    , vsbps :: [Int]
    , vspause :: Maybe Pause
    } deriving(Show)

vstate :: Memory -> VState
vstate m = VState m [] Nothing

-- | Main simulation monad. Supports breakpoints and IO. [Int] is a list of
-- active breakpoint identifiers
newtype VSim a = VSim { unVSim :: BP () VState IO a }
    deriving(Monad, MonadIO, Functor, Applicative, MonadPtr, MonadState VState)

-- | Runs simulation monad. BPS is a list of breakpoints to stop at.
runVSim :: VSim a -> VState -> IO (VState, Either (VSim a) a)
runVSim sim st = do
    (st', e) <- runBP (unVSim sim) st
    case e of
        Left k -> return (st', Left (VSim k))
        Right a -> return (st', Right a)
        
class (MonadPtr m) => MonadSim m where
    pause :: Pause -> m ()

instance MonadSim VSim where
    pause p = modify (\s -> s{vspause = Just p}) >> VSim pauseBP

instance MonadMem VSim where
    get_mem = vsmem <$> get
    put_mem m' = modify (\s -> s{vsmem = m'})

terminate :: (MonadSim m) => Time -> String -> m ()
terminate t s = pause $ Report t High s

{- VProc monad -}

-- | The reason VHDL process is being paused
data ProcPause = PPsig [AnyPrimitiveSignal] | PPtime NextTime
    deriving (Show)

data AssignTracker = AT {
      aas :: [AnyPrimitive Assignment]
    , ats :: Map.Map NextTime Event
    } deriving(Show)

instance Monoid AssignTracker where
    mempty = AT [] Map.empty
    mappend = mergeTrackers

mergeTrackers :: AssignTracker -> AssignTracker -> AssignTracker
mergeTrackers a1 a2 = AT ((aas a1) ++ (aas a2)) (Map.unionWith mappend (ats a1) (ats a2))

add_assignment_simple :: (Ord x, Show x) =>
    Signal x -> NextTime -> Waveform x -> x -> AssignTracker -> AssignTracker
add_assignment_simple s t wv v (AT aas ats) = AT (a':aas) (Map.insertWith mappend t e' ats) where
    e' = Event [AnyPrimitiveSignal s] mempty
    a' = AnyPrimitive (Assignment s (concatAt t wv (wconst v)))

add_process_kick :: Ptr Process -> NextTime -> AssignTracker -> AssignTracker
add_process_kick p t (AT aas ats) = AT aas (Map.insertWith mappend t e' ats) where
        e' = Event [] (Set.singleton p)

-- | The state of a VHDL process
data PS = PS {
    -- | Current simulation time
      ptime :: Time
    -- | Old-style assignments
    -- , passignments :: [Assignment Int]
    -- | New-style assignment tracker
    , passgnt :: AssignTracker
    -- | Reason the process is being paused
    , ppause :: Maybe ProcPause
    } deriving(Show)

track :: (AssignTracker -> AssignTracker) ->  PS -> PS
track fat ps = ps { passgnt = fat (passgnt ps) } where

-- | Monad for process execution.
newtype VProc l a = VProc { unProc :: BP l PS VSim a }
    deriving (Monad, MonadIO, MonadPtr, Functor, Applicative, MonadState PS)

class (MonadSim m, MonadState PS m) => MonadProc m where
    wait :: ProcPause -> m ()

instance MonadProc (VProc l) where
    wait pp = modify (\s -> s {ppause = Just pp}) >> VProc pauseBP

instance MonadSim (VProc l) where
    pause = VProc . lift . pause

runVProc :: VProc () () -> PS -> VSim (PS, Either ProcessHandler ())
runVProc (VProc r) s = do
    (s', eh) <- runBP r s
    return (s', case eh of Left h -> Left (VProc h)
                           Right () -> Right ())

runProcess :: Ptr Process -> PS -> VSim PS
runProcess r s = do
    p <- derefM r
    (s',p') <- runProcess' p s
    writeM r p'
    return s'

runProcess' :: Process -> PS -> VSim (PS, Process)
runProcess' p s = do
    (s', eh) <- runVProc (phandler p) s
    case eh of
        Left h' -> return (s', p{pcont = eh})
        Right () -> runProcess' p{pcont = eh} s'

catchEarlyV :: VProc l r -> VProc l2 (Either l r)
catchEarlyV (VProc bp) = VProc (catchEarly bp)

-- | Pauses process with the report
report :: (MonadProc m) => m String -> m ()
report s = pause =<< (Report <$> now <*> pure Low <*> s)

-- | Pauses process with the assertion
assert :: (MonadProc m) => m ()
assert = pause =<< (Report <$> now <*> pure High <*> pure "assert")

-- | Pauses process with the breakpoint
breakpoint :: (MonadProc m) => m ()
breakpoint = pause =<< (BreakHit <$> now <*> pure 0)



{- Elab monad -}

class (MonadMem m) => MonadElab m

newtype Elab m a = Elab { unElab :: (StateT Memory m) a }
    deriving(Monad, Applicative, Functor, MonadIO, MonadPtr, MonadMem, MonadFix)

instance (MonadPtr m) => MonadElab (Elab m)

runElab e = runStateT (unElab e) emptyMem


-- | Type hint for ints
int :: (Monad m) => Int -> m Int
int = return

-- | Type hint for strings
str :: (Monad m) => String -> m String
str = return



data EnumT = EnumT {
      esize :: Int
    }
    deriving(Show)

newtype EnumVal = EnumVal Int
    deriving(Show)

type Plan = [(Signal Int, Int)]

type Agg m tgt = tgt -> m tgt

-- data Clone = Clone
-- data Link = Link

pfail x a = fail (printf (x ++ "\n") a)
pfail2 x a b = fail (printf (x ++ "\n") a b)
pfail3 x a b c = fail (printf (x ++ "\n") a b c)

{- Common helpers -}
when_not x fail = when (not x) fail

unMaybeM Nothing fail = fail
unMaybeM (Just x) _ = return x

loopM a b f = foldM f a b


class (Monad m, Monad mi) => Parent m mi | m -> mi where
    hug :: mi x -> m x
    unM :: m x -> mi x

newtype Link m a = Link { unLink :: (Elab m) a }
    deriving(Monad, Applicative, Functor, MonadIO, MonadPtr, MonadMem, MonadElab)

instance (Monad m) => Parent (Link m) (Elab m) where
    hug me = Link me
    unM = unLink

newtype Clone m a = Clone { unClone :: m a }
    deriving(Monad, Applicative, Functor, MonadIO, MonadPtr, MonadMem, MonadElab)

instance (Monad m) => Parent (Clone m) m where
    hug me = Clone me
    unM = unClone

newtype Assign l a = Assign { unAssign :: StateT Plan (VProc l) a }
    deriving(Monad, Applicative, Functor, MonadIO, MonadPtr, MonadState Plan)

runAssign mx = execStateT (unAssign mx) []
evalAssign mx = evalStateT (unAssign mx) []

instance Parent (Assign l) (VProc l) where
    hug me = Assign (lift me)
    unM = evalAssign

-- | Container for the data referencing to primitive values
data AnyPrimitive c where
    AnyPrimitive :: (Show t, Show (c t), Ord t) => c t -> AnyPrimitive c

instance Show (AnyPrimitive c) where
    show (AnyPrimitive x) = printf "AnyPrimitive %s" (show x)

-- | Container for primitive signals
data AnyPrimitiveSignal where
    AnyPrimitiveSignal :: (Show t) => Signal t -> AnyPrimitiveSignal

instance Show AnyPrimitiveSignal where
    show (AnyPrimitiveSignal x) = printf "AnyPrimitiveSignal %s" (show x)

