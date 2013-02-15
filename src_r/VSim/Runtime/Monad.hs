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
import Data.Range
import Data.IntMap as IntMap
import Data.Array2
import Data.Set as Set
import Text.Printf

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

-- | VHDL primitive signal
data SigR t = SigR {
      swave :: Waveform t
    , sproc :: Set.Set (Ptr Process)
    , suniq :: Int
    } deriving(Show)

instance HasUniq (SigR t) where
    getUniq = suniq

type Signal t = Value (PrimitiveT t) (Ptr (SigR t))

type Constant = Value (PrimitiveT Int) Int

signalUniqIq :: (MonadPtr m) => Signal Int -> m Int
signalUniqIq s = suniq <$> derefM (vr s)

in_range :: (PrimitiveT Int) -> Int -> Bool
in_range (PrimitiveT l u) v = v >= l && v <= u

in_range_w :: PrimitiveT Int -> Waveform Int -> Bool
in_range_w t w = and $ List.map f $ wchanges w where
    f (Change _ v) = in_range t v

instance (MonadPtr m) => Constrained m (Signal Int) where
    ccheck (Value n t r) = derefM r >>= \s -> do
        when (not $ in_range_w t (swave s)) $ do
            pfail3 "constrained failed: name %s type (%s) val (%s)" n (show t) (show (swave s))

instance (MonadPtr m) => Constrained m Variable where
    ccheck (Value n t r) = derefM r >>= \v -> ccfail_ifnot v (in_range t (vval v))

sigassign1 :: (MonadPtr m, Constrained m (Signal Int)) => Assignment Int -> m ()
sigassign1 (Assignment v pw) = do
    s <- derefM (vr v)
    writeM (vr v) s{ swave = unPW (swave s) pw }
    ccheck v

sigassign2 :: (MonadPtr m) => (Signal t) -> m (Set.Set (Ptr Process))
sigassign2 v = do
    s <- derefM (vr v)
    writeM (vr v) s{swave = (snd . event . swave $ s)}
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
      acurr :: Signal t
    , anext :: ProjectedWaveform t
    } deriving(Show)

add_assignment :: Assignment Int -> PS -> PS
add_assignment a ps = ps { passignments = a:(passignments ps) }

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
    , phandler :: ProcessHandler
    -- ^ Returns newly-assigned signals
    , pawake :: Maybe NextTime
    , psignals :: [Ptr (SigR Int)]
    , puniq :: Int
    -- ^ Unique identifier
    }

instance Show Process where
    show p = printf "Process { pname = \"%s\" }" (pname p)

instance HasUniq Process where
    getUniq = puniq

debug s = liftIO . putStrLn $ "debug: " ++ s

relink :: (MonadPtr m) => Ptr Process -> [Ptr (SigR Int)] -> m ()
relink r ss = do
    p <- derefM r
    mapM_ (updateM (rmproc r)) (psignals p)
    mapM_ (updateM (addproc r)) ss
    writeM r p{psignals = ss}
    where 
        rmproc r s = s{ sproc = Set.delete r (sproc s)}
        addproc r s = s{ sproc = Set.insert r (sproc s)}

rewind :: (MonadSim m) => Ptr Process -> ProcessHandler -> Maybe NextTime -> m ()
rewind r h nt = do
    p <- derefM r
    writeM r p{phandler = h, pawake = nt}

data Memory = Memory {
      msignals :: IntMap [AnyPrimitiveSignal]
    , mprocesses :: [Ptr Process]
    } deriving(Show)

noProcesses (Memory _ []) = True
noProcesses (Memory _ _) = False

emptyMem :: Memory
emptyMem = Memory IntMap.empty []

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

-- | Simulation event
newtype SimStep = SimStep (Set.Set (Ptr Process))
    deriving(Show)

start_step :: Memory -> (Time, SimStep)
start_step m = (minBound, SimStep (Set.fromList $ mprocesses m))


{- VSim monad -}

data Severity = Low | High
    deriving(Show)

-- | A reason to pause the simulation
data Pause =
      Report Time Severity String
    | BreakHit Time Int
    deriving(Show)

data VState = VState {
      vsmem :: Memory
    , vsbps :: [Int]
    , vspause :: Maybe Pause
    } deriving(Show)

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

-- | The reason, VHDL process is being paused
data ProcPause = PP [Ptr (SigR Int)] (Maybe NextTime)
    deriving (Show)

-- | State of a VHDL process
data PS = PS {
      ptime :: Time
    , passignments :: [Assignment Int]
    , ppause :: Maybe ProcPause
    } deriving(Show)

-- | Monad for process execution.
newtype VProc l a = VProc { unProc :: BP l PS VSim a }
    deriving (Monad, MonadIO, MonadPtr, Functor, Applicative, MonadState PS)

class (MonadSim m, MonadState PS m) => MonadProc m where
    wait :: ProcPause -> m ()

instance MonadProc (VProc l) where
    wait pp = modify (\s -> s{ppause = Just pp}) >> (VProc pauseBP) 

instance MonadSim (VProc l) where
    pause = VProc . lift . pause

runVProc :: VProc () () -> PS -> VSim (PS,VProc () ())
runVProc (VProc r) s = do
    (s',er) <- runBP r s
    case er of
        Left k -> return (s', VProc k)
        Right _ -> fail "runVProc: process has been terminated"

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

newtype Assign m a = Assign { unAssign :: StateT Plan m a }
    deriving(Monad, Applicative, Functor, MonadIO, MonadPtr, MonadState Plan)

runAssign mx = execStateT (unAssign mx) []
evalAssign mx = evalStateT (unAssign mx) []

instance (Monad m) => Parent (Assign m) m where
    hug me = Assign (lift me)
    unM = evalAssign

-- | Container for primitive signals
data AnyPrimitiveSignal where
    AnyPrimitiveSignal :: (Show t) => Signal t -> AnyPrimitiveSignal

instance Show AnyPrimitiveSignal where
    show (AnyPrimitiveSignal x) = printf "AnyPrimitiveSignal %s" (show x)

