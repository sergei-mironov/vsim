{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}

module VSim.Runtime.Monad where

import Control.Applicative
import Control.Monad.BP
import Control.Monad.State
import Control.Monad.Reader
import Control.Monad.Identity
import Control.Monad.Trans
import Data.Monoid
import qualified Data.IntMap as IntMap
import Data.List
import Data.Range
import Data.Array2
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


data Value t x = Value {
      vt :: t
    , vn :: String
    , vr :: x
    } deriving(Show)

-- | VHDL primitive type can are described with it's upper and lower bounds. Use
-- of Ints is a limitation of a current implementation.
data PrimitiveT = PrimitiveT {
      lower :: Int
    , upper :: Int
    } deriving(Show)

ranged a b = PrimitiveT a b
unranged = PrimitiveT minBound maxBound

-- | VHDL variable (runtime representation)
newtype VarR = VarR { vval :: Int } deriving(Show)

-- instance (MonadPtr m) => Cloneable m (Ptr a) where
--     clone r = derefM r >>= allocM 

type Variable = Value PrimitiveT (Ptr VarR)

-- | VHDL primitive signal
data SigR = SigR {
      swave :: Waveform
    , sproc :: [Ptr Process]
    , suniq :: Int
    } deriving(Show)

type Signal = Value PrimitiveT (Ptr SigR)

signalUniqIq :: (MonadPtr m) => Signal -> m Int
signalUniqIq s = suniq <$> derefM (vr s)

in_range :: PrimitiveT -> Int -> Bool
in_range (PrimitiveT l u) v = v >= l && v <= u

in_range_w :: PrimitiveT -> Waveform -> Bool
in_range_w t w = and $ map f $ wchanges w where
    f (Change _ v) = in_range t v

instance (MonadPtr m) => Constrained m Signal where
    ccheck (Value t _ r) = derefM r >>= \s -> ccfail_ifnot s (in_range_w t (swave s))

instance (MonadPtr m) => Constrained m Variable where
    ccheck (Value t _ r) = derefM r >>= \v -> ccfail_ifnot v (in_range t (vval v))

sigassign1 :: (MonadSim m, Constrained m Signal) => Assignment -> m ()
sigassign1 (Assignment v pw) = do
    s <- derefM (vr v)
    writeM (vr v) s{ swave = unPW (swave s) pw }
    ccheck v

sigassign2 :: (MonadSim m) => Ptr SigR -> Waveform -> m [Ptr Process]
sigassign2 r w = do
    s <- derefM r
    writeM r s{swave = w}
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
type Array t e = Value (ArrayT t) (ArrayR (String,e))

-- | Assignment event, list of them is the result of process execution
data Assignment = Assignment {
      acurr :: Signal
    , anext :: ProjectedWaveform
    } deriving(Show)

add_assignment :: Assignment -> PS -> PS
add_assignment a ps = ps { passignments = a:(passignments ps) }

-- | VHDL record type
newtype RecordT x = RecordT x
    deriving(Show)

-- | VHDL records
data RecordR a = RecordR {
      rname :: String
    , rtuple :: a
    } deriving(Show)

type Accessor r f = (r -> f)

type Record t x = (RecordT t, Ptr (RecordR x))

-- | State of a VHDL process
data PS = PS {
      ptime :: Time
    , passignments :: [Assignment]
    } deriving(Show)

now :: (MonadState PS m) => m Time
now = ptime `liftM` get

type ProcessHandler = VProc () ()

-- | Representation of VHDL's process
data Process = Process {
      pname :: String
    -- ^ The name of a process
    , phandler :: ProcessHandler
    -- ^ Returns newly-assigned signals
    , pawake :: Maybe NextTime
    , psignals :: [Ptr SigR]
    }

instance Show Process where
    show p = printf "Process { pname = \"%s\" }" (pname p)

relink :: (MonadSim m) => Ptr Process -> [Ptr SigR] -> m ()
relink r ss = do
    p <- derefM r
    mapM_ (updateM (rmproc r)) (psignals p)
    mapM_ (updateM (addproc r)) ss
    writeM r p{psignals = ss}
    where 
        rmproc r s = s{ sproc = delete r (sproc s)}
        addproc r s = s{ sproc = r:(sproc s)}

rewind :: (MonadSim m) => Ptr Process -> ProcessHandler -> Maybe NextTime -> m ()
rewind r h nt = do
    p <- derefM r
    writeM r p{phandler = h, pawake = nt}

data Memory = Memory {
      msignals :: [Signal]
    , mprocesses :: [Ptr Process]
    } deriving(Show)

emptyMem :: Memory
emptyMem = Memory [] []

-- | Simulation event
newtype SimStep = SimStep [Ptr Process]
    deriving(Show)

start_step :: Memory -> (Time, SimStep)
start_step m = (minBound, SimStep (mprocesses m))


data Severity = Low | High
    deriving(Show)

-- | A reason to pause the simulation
data Pause =
      Report Time Severity String
    | BreakHit Time Int
    deriving(Show)

type VState = (Memory, [Int])

-- | Main simulation monad. Supports breakpoints and IO. [Int] is a list of
-- active breakpoint identifiers
newtype VSim a = VSim { unVSim :: BP () Pause (StateT VState IO) a }
    deriving(Monad, MonadIO, Functor, Applicative, MonadBP Pause, 
        MonadState VState, MonadPtr)

class (MonadPtr m, MonadBP Pause m) => MonadSim m

instance MonadMem VSim where
    get_mem = get >>= \ (m,_) -> return m
    put_mem m = modify (\(_,b) -> (m,b))

instance MonadSim VSim

-- | Runs simulation monad. BPS is a list of breakpoints to stop at.
runVSim :: VSim a -> VState -> IO (Either (Pause, Memory, VSim a) a)
runVSim sim st = do
    (e, (m,_)) <- runStateT (runBP (unVSim sim)) st
    case e of
        Left (p,bp) -> return (Left (p, m, VSim bp))
        Right a -> return (Right a)

data ProcPause = PP [Ptr SigR] (Maybe NextTime)
    deriving (Show)

-- | Monad for process execution.
newtype VProc l a = VProc { unProc :: BP l (ProcPause,PS) (StateT PS VSim) a }
    deriving (Monad, MonadIO, MonadPtr, Functor, Applicative, MonadState PS)

class (MonadPtr m, MonadState PS m) => MonadProc m

instance MonadProc (VProc l)

class (MonadProc m, MonadBP Pause m) => MonadWait m where
    wait_until :: NextTime -> m ()
    wait_on :: [Ptr SigR] -> m ()

instance MonadBP Pause (VProc l) where
    pause = VProc . lift . lift . pause
    halt =  VProc . lift . lift . halt

instance MonadWait (VProc l) where
    wait_until nt = get >>= \s -> VProc (pause (PP [] (Just nt),s))
    wait_on ss = get >>= \s -> VProc (pause (PP ss Nothing,s))

runVProc :: VProc () () -> PS -> VSim ((ProcPause,PS),VProc () ())
runVProc (VProc r) s = do
    (e,s') <- runStateT (runBP r) s
    case e of
        Left (x,k) -> return (x, VProc k)
        Right _ -> error "runVProc: some process has been terminated"

catchEarlyV :: VProc l1 l1 -> VProc l2 l1
catchEarlyV (VProc bp) = VProc (catchEarly bp)

terminate :: (MonadBP Pause m) => Time -> String -> m ()
terminate t s = halt $ Report t High s

-- | Pauses process with the report
report :: (MonadBP Pause m, MonadWait m) => m String -> m ()
report s = pause =<< (Report <$> now <*> pure Low <*> s)

-- | Pauses process with the assertion
assert :: (MonadWait m) => m ()
assert = pause =<< (Report <$> now <*> pure High <*> pure "assert")

-- | Pauses process with the breakpoint
breakpoint :: (MonadWait m) => m ()
breakpoint = pause =<< (BreakHit <$> now <*> pure 0)

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

type Plan = [(Signal, Int)]

type Agg m method tgt = method -> tgt -> m tgt

data Clone = Clone

data Link = Link

-- FIXME: bad arguments handling
pfail x = fail . printf (x ++ "\n")

{- Common helpers -}
when_not x fail = when (not x) fail

unMaybeM Nothing fail = fail
unMaybeM (Just x) _ = return x

loopM a b f = foldM f a b


-- newtype Link m a = Link { unLink :: m a }
--     deriving(Monad, Applicative, Functor, MonadIO, MonadPtr, MonadMem, MonadElab)

-- instance MonadTrans Link where lift = Link


-- newtype Clone m a = Clone { unClone :: m a }
--     deriving(Monad, Applicative, Functor, MonadIO, MonadPtr, MonadMem, MonadElab)

-- instance MonadTrans Clone where lift = Clone


-- newtype Access m a = Access { unAccess :: m a }
--     deriving(Monad, Applicative, Functor, MonadIO, MonadPtr, MonadMem, MonadElab)

-- instance MonadTrans Access where lift = Access

