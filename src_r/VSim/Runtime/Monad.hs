{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeOperators #-}

module VSim.Runtime.Monad where

import Control.Monad.BP
import Control.Monad.State
import Control.Monad.Reader
import Control.Monad.Identity
import Control.Monad.Trans
import Control.Applicative
import Data.Monoid
import qualified Data.IntMap as IntMap
import Data.List
import Data.IORef
import Text.Printf
import System.IO
import System.IO.Unsafe

import VSim.Runtime.Time
import VSim.Runtime.Waveform

-- | Pointer type used in the simulator
type Ptr x = IORef x

class (MonadIO m, Applicative m) => MonadMem m where
    get_mem :: m Memory
    put_mem :: Memory -> m ()
    -- | Embed a simple state action into the monad.
    state_mem :: (Memory -> (a, Memory)) -> m a
    state_mem f = do
      s <- get_mem
      let ~(a, s') = f s
      put_mem s'
      return a

instance (MonadMem m) => MonadMem (ReaderT s m) where
    get_mem = lift $ get_mem
    put_mem = lift . put_mem

modify_mem :: MonadMem m => (Memory -> Memory) -> m ()
modify_mem f = state_mem (\s -> ((), f s))

alloc :: (MonadIO m) => mem -> a -> m (mem, Ptr a)
alloc mem a = liftIO (newIORef a) >>= \r -> return (mem,r)

write :: (MonadIO m) => mem -> Ptr a -> a -> m mem
write mem ptr a = liftIO (writeIORef ptr a) >> return mem

deref :: (MonadIO m) => mem -> Ptr a -> m a
deref mem ptr = liftIO $ readIORef ptr

update :: (MonadIO m) => mem -> (a->a) -> Ptr a -> m mem
update mem f ptr = deref mem ptr >>= write mem ptr . f

withPtr :: (MonadIO m) => mem -> (a->(a,b)) -> Ptr a -> m (mem, b)
withPtr mem f ptr = deref mem ptr >>= \a -> do
    let (a',b) = f a in write mem ptr a' >>= \mem' -> return (mem',b)

writeM :: (MonadMem m) => Ptr a -> a -> m ()
writeM ptr a = get_mem >>= \m -> write m ptr a >>= \m' -> put_mem m'

derefM :: (MonadMem m) => Ptr a -> m a
derefM r = get_mem >>= \m -> deref m r

derefM' :: (MonadMem m) => Ptr a -> m (Ptr a, a)
derefM' r = derefM r >>= \v -> return (r,v)

allocM :: (MonadMem m) => a -> m (Ptr a)
allocM x = get_mem >>= \m -> alloc m x >>= \(m',x) -> put_mem m' >> return x

updateM :: (MonadMem m) => (a->a) -> Ptr a -> m ()
updateM f r = get_mem >>= \m -> update m f r >>= \m' -> put_mem m'

withPtrM :: (MonadMem m) => (a->(a,b)) -> Ptr a -> m b
withPtrM f ptr = get_mem >>= \m -> withPtr m f ptr >>= \(m',b) -> put_mem m' >> return b

instance (Show x) => Show (IORef x) where
    show x = "@(" ++ show (unsafePerformIO $ deref undefined x) ++ ")"

-- | VHDL constrained type
data Constraint = Constraint {
      lower :: Int
    , upper :: Int
    } deriving(Show)

ranged a b = Constraint a b
unranged = Constraint minBound maxBound

class Constrained x where
    within :: x -> Bool

instance Constrained (Int, Constraint) where
    within (v,(Constraint l u)) = v >= l && v <= u

-- | VHDL variable
data Variable = Variable {
      vname :: String
    , vval :: Int
    , vconstr :: Constraint
    } deriving(Show)

instance Constrained Variable where
    within v = within (vval v, vconstr v)

-- | VHDL signal
data Signal = Signal {
      sname :: String
    , swave :: Waveform
    , oldvalue :: Int
    , sconstr :: Constraint
    , sproc :: [Ptr Process]
    } deriving(Show)

instance Constrained Signal where
    within s = and $ map f $ wchanges $ swave s where
        f (Change _ v) = within (v, sconstr s)

sigassign1 :: (MonadSim m) => Assignment -> m (Either String ())
sigassign1 (Assignment r pw) = do
    s <- derefM r
    let w' = unPW (swave s) pw
    let s' = s { swave = w' }
    case (within s') of
        False -> return (Left (sname s))
        True -> writeM r s' >> return (Right ())

sigassign2 :: (MonadSim m) => Ptr Signal -> Waveform -> m [Ptr Process]
sigassign2 r w = do
    s <- derefM r
    writeM r s{swave = w}
    return (sproc s)

-- | VHDL array type
data ArrayT t = ArrayT {
      aconstr :: t
    , abegin :: Int
    , aend :: Int
    } deriving(Show)

-- VHDL arrays
data Array t a = Array {
      cname :: String
    , csignals :: IntMap.IntMap a
    , cconstr :: ArrayT t
    } deriving(Show)

index :: (MonadMem m) => m Int -> m (Ptr (Array t a)) -> m a
index mi c = do
    mb <- IntMap.lookup <$> mi <*> (csignals <$> (derefM =<< c))
    maybe (fail "index: out of range") return mb

-- | Assignment event, list of them is the result of process execution
data Assignment = Assignment {
      acurr :: Ptr Signal
    , anext :: ProjectedWaveform
    } deriving(Show)

add_assignment :: Assignment -> PS -> PS
add_assignment a ps = ps { passignments = a:(passignments ps) }

-- | VHDL records
data Record a = Record {
      rname :: String
    , rtuple :: a
    } deriving(Show)

field :: (MonadMem m) => (x -> y) -> m (Ptr (Record x)) -> m y
field fsel mr = (fsel . rtuple) <$> (derefM =<< mr)

-- | Process State
data PS = PS {
      ptime :: Time
    , passignments :: [Assignment]
    } deriving(Show)

now :: (Functor m, MonadState PS m) => m Time
now = ptime <$> get

type ProcessHandler = VProc ()

-- | Representation of VHDL's process
data Process = Process {
      pname :: String
    -- ^ The name of a process
    , phandler :: ProcessHandler
    -- ^ Returns newly-assigned signals
    , pawake :: Maybe NextTime
    , psignals :: [Ptr Signal]
    }

instance Show Process where
    show p = printf "Process { pname = \"%s\" }" (pname p)

relink :: (MonadSim m) => Ptr Process -> [Ptr Signal] -> m ()
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
      msignals :: [Ptr Signal]
    , mprocesses :: [Ptr Process]
    } deriving(Show)

emptyMem :: Memory
emptyMem = Memory [] []

instance MonadMem (StateT Memory IO) where
    get_mem = get
    put_mem = put

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
newtype VSim a = VSim { unVSim :: BP Pause (StateT VState IO) a }
    deriving(Monad, MonadIO, Functor, Applicative)

class (Applicative m, MonadMem m, MonadBP Pause m) => MonadSim m

instance MonadBP Pause VSim where
    pause = VSim . pause
    halt = VSim . halt

instance MonadMem VSim where
    get_mem = VSim $ lift $ get >>= \ (m,_) -> return m
    put_mem m = VSim $ lift $ modify (\(_,b) -> (m,b))

instance MonadSim VSim

-- | Runs simulation monad. BPS is a list of breakpoints to stop at.
runVSim :: VSim a -> VState -> IO (Either (Pause, Memory, VSim a) a)
runVSim sim st = do
    (e, (m,_)) <- runStateT (runBP (unVSim sim)) st
    case e of
        Left (p,bp) -> return (Left (p, m, VSim bp))
        Right a -> return (Right a)

data ProcPause = PP [Ptr Signal] (Maybe NextTime)
    deriving (Show)

-- | Monad for process execution.
newtype VProc a = VProc { unProc :: BP (ProcPause,PS) (StateT PS VSim) a }
    deriving (Monad, MonadIO, Functor, Applicative)

class (MonadMem m, MonadState PS m) => MonadProc m

instance MonadProc VProc

class (MonadProc m, MonadBP Pause m) => MonadWait m where
    wait_until :: NextTime -> m ()
    wait_on :: [Ptr Signal] -> m ()

instance MonadBP Pause VProc where
    pause = VProc . lift . lift . pause
    halt =  VProc . lift . lift . halt

instance MonadState PS VProc where
    get = VProc $ lift $ get
    put = VProc . lift . put

instance MonadMem VProc where
    get_mem = VProc $ lift $ lift $ get_mem
    put_mem = VProc . lift . lift . put_mem

instance MonadWait VProc where
    wait_until nt = get >>= \s -> VProc (pause (PP [] (Just nt),s))
    wait_on ss = get >>= \s -> VProc (pause (PP ss Nothing,s))

runVProc :: VProc () -> PS -> VSim ((ProcPause,PS),VProc ())
runVProc (VProc r) s = do
    (e,s') <- runStateT (runBP r) s
    case e of
        Left (x,k) -> return (x, VProc k)
        Right _ -> error "runVProc: some process has been terminated"

terminate :: (MonadBP Pause m) => Time -> String -> m ()
terminate t s = halt $ Report t High s

-- | Pauses process with the report
report :: (MonadWait m) => m String -> m ()
report s = pause =<< (Report <$> now <*> pure Low <*> s)

-- | Pauses process with the assertion
assert :: (MonadWait m) => m ()
assert = pause =<< (Report <$> now <*> pure High <*> pure "assert")

-- | Pauses process with the breakpoint
breakpoint :: (MonadWait m) => m ()
breakpoint = pause =<< (BreakHit <$> now <*> pure 0)

class (MonadMem m) => MonadElab m

newtype Elab a = Elab { unElab :: (StateT Memory IO) a }
    deriving(Monad, MonadMem, Applicative, Functor, MonadIO)

instance MonadElab Elab

runElab e = runStateT (unElab e) emptyMem

-- | Type hint for ints
int :: (Monad m) => Int -> m Int
int = return

-- | Type hint for strings
str :: (Monad m) => String -> m String
str = return

class (MonadProc m, MonadReader NextTime m) => MonadAssign m

-- | Monad for producing signal assignments from within processes
newtype VAssign a = VAssign { unAssign :: ReaderT NextTime VProc a }
    deriving(MonadMem, Monad, Functor, MonadIO, Applicative, MonadReader NextTime,
        MonadState PS)

instance MonadProc VAssign
instance MonadAssign VAssign

runVAssign :: NextTime -> VAssign a -> VProc ()
runVAssign nt va = runReaderT (unAssign va) nt >> return ()

class (Monad m) => Assignable m c v where
    assign :: m v -> m c -> m c

type Assigner m a = m a -> m a

aggregate :: (MonadMem m) => [a -> m a] -> m a -> m a
aggregate fs mr = mr >>= \r -> foldM (flip ($)) r fs

setfld :: (MonadMem m) => (z -> x) -> Assigner m x -> Ptr (Record z) -> m (Ptr (Record z))
setfld fs f r = f (field fs (pure r)) >> return r

setidx :: (MonadMem m) => m Int -> Assigner m x -> Ptr (Array t x) -> m (Ptr (Array t x))
setidx mi f r = f (index mi (pure r)) >> return r

