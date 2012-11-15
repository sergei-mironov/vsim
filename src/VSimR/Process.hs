module VSimR.Process where

import Control.Applicative
import Control.Monad.Trans
import Control.Monad.Reader
import Control.Monad.State

import VSimR.Monad
import VSimR.Time
import VSimR.Ptr
import VSimR.Waveform
import VSimR.Variable

data Signal = Signal {
      sname :: String
    , wcurr :: Waveform
    , oldvalue :: Int
    , sconstr :: Constraint
    , proc :: [Ptr Process]
    } deriving(Show)

chwave :: Waveform -> Signal -> Signal
chwave w s = s { wcurr = w }

addproc :: Ptr Process -> Signal -> Signal
addproc p s = s { proc = p:(proc s) }

withinW :: Constraint -> Waveform -> Bool
withinW c (Waveform cs) = and $ map (within c) . map cvalue $ cs

-- earliest :: Signal -> Signal -> Ordering
-- earliest s1 s2 = W.earliest (wcurr s1) (wcurr s2)

now :: (MonadProc m) => m Time
now = ask

ms :: (MonadProc m) => Time -> m Time
ms t = (+) <$> now <*> (pure $ t * milliSecond)

us :: (MonadProc m) => Time -> m Time
us t = (+) <$> now <*> (pure $ t * microSecond)

ps :: (MonadProc m) => Time -> m Time
ps t = (+) <$> now <*> (pure $ t * picoSecond)

ns :: (MonadProc m) => Time -> m Time
ns t = (+) <$> now <*> (pure $ t * nanoSecond)

int :: (MonadProc m) => Int -> m Int
int = return

-- | Assigns new constant waveform to a signal
assign :: (MonadProc m) => Ptr Signal -> (m Time, m Int) -> m (Assignment)
assign p (mt,mv) = Assignment <$> pure p <*> (PW <$> mt <*> (wconst <$> mv))

(.+.) :: (MonadProc m) => m Int -> m Int -> m Int
(.+.) a b = (+) <$> a <*> b

(.-.) :: (MonadProc m) => m Int -> m Int -> m Int
(.-.) a b = (-) <$> a <*> b

-- | Etracts signal's current value
val :: (MonadProc m) => Ptr Signal -> m Int
val r = valueAt1 <$> ask <*> (wcurr `liftM` deref r)

stable :: (Monad m) => Int -> m Int
stable i = return i

data Assignment = Assignment {
      scurr :: Ptr Signal
    , wnext :: ProjectedWaveform
    } deriving(Show)

type ProcessHandler= VProc VSim [Assignment]

data Process = Process {
      pname :: String
    -- ^ The name of a process
    , phandler :: ProcessHandler
    -- ^ Returns newly-assigned signals
    }

instance Show (Process) where
    show _ = "Process <handler>"

runProcess :: Time -> Process -> VSim [Assignment]
runProcess t (Process _ h) = runVProc t h

