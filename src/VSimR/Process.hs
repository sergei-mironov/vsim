{-# LANGUAGE FlexibleContexts #-}

module VSimR.Process where

import Control.Applicative
import Control.Monad.Trans
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.BP
import Text.Printf

import VSimR.Monad
import VSimR.Time
import VSimR.Ptr
import VSimR.Waveform
import VSimR.Variable

data Signal = Signal {
      sname :: String
    , scurr :: Waveform
    , oldvalue :: Int
    , sconstr :: Constraint
    , proc :: [Ptr Process]
    } deriving(Show)

chwave :: Waveform -> Signal -> Signal
chwave w s = s { scurr = w }

addproc :: Ptr Process -> Signal -> Signal
addproc p s = s { proc = p:(proc s) }

instance Constrained Signal where
    within s = and $ map f $ wchanges $ scurr s where
        f (Change _ v) = within (v, sconstr s)

printSignalM :: (MonadIO m) => Ptr Signal -> m String
printSignalM r = deref r >>= return . printSignal

printSignal :: Signal -> String
printSignal s = printf "signal %s wave %s" (sname s) (printWaveform (scurr s))

-- | Assignment event
data Assignment = Assignment {
      acurr :: Ptr Signal
    , anext :: ProjectedWaveform
    } deriving(Show)

-- | Process State
data PS = PS {
      ptime :: Time
    , passignments :: [Assignment]
    } deriving(Show)

add_assignment :: Assignment -> PS -> PS
add_assignment a (PS t as) = PS t (a:as)

type ProcessHandler = VProc PS VSim ()

-- | Representation of VHDL's process
data Process = Process {
      pname :: String
    -- ^ The name of a process
    , phandler :: ProcessHandler
    -- ^ Returns newly-assigned signals
    }

instance Show Process where
    show p = printf "Process { pname = \"%s\", <handler> }" (pname p)

now :: (MonadProc PS m) => m Time
now = ptime <$> get

ms :: (MonadProc PS m) => Time -> m Time
ms t = (+) <$> now <*> (pure $ t * milliSecond)

us :: (MonadProc PS m) => Time -> m Time
us t = (+) <$> now <*> (pure $ t * microSecond)

ps :: (MonadProc PS m) => Time -> m Time
ps t = (+) <$> now <*> (pure $ t * picoSecond)

ns :: (MonadProc PS m) => Time -> m Time
ns t = (+) <$> now <*> (pure $ t * nanoSecond)

fs :: (MonadProc PS m) => Time -> m Time
fs t = (+) <$> now <*> (pure $ t * femtoSecond)

int :: (MonadProc s m) => Int -> m Int
int = return

-- | Assigns new constant waveform to a signal
assign :: (MonadProc PS m) => Ptr Signal -> (m Time, m Int) -> m ()
assign p (mt,mv) = do
    a <- Assignment <$> pure p <*> (PW <$> mt <*> (wconst <$> mv))
    modify (add_assignment a)

(.+.) :: (MonadProc PS m) => m Int -> m Int -> m Int
(.+.) a b = (+) <$> a <*> b

(.-.) :: (MonadProc PS m) => m Int -> m Int -> m Int
(.-.) a b = (-) <$> a <*> b

-- | Etracts signal's current value
val :: (MonadProc PS m) => Ptr Signal -> m Int
val r = valueAt1 <$> now <*> (scurr `liftM` deref r)

stable :: (Monad m) => Int -> m Int
stable i = return i

runProcess :: Time -> Process -> VSim [Assignment]
runProcess t (Process _ h) = passignments <$> runVProc h (PS t [])

report :: (MonadProc PS m) => String -> m ()
report s = do
    r <- Report <$> now <*> pure Low <*> pure s
    pause r

breakpoint :: (MonadProc PS m) => m ()
breakpoint = do
    r <- BreakHit <$> now <*> pure 0
    pause r

