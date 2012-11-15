{-# LANGUAGE FlexibleContexts #-}

module VSimR.Process where

import Control.Applicative
import Control.Monad.Trans
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.BP

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

-- withinW :: Constraint -> Waveform -> Bool
-- withinW c (Waveform cs) = and $ map (within c) . map cvalue $ cs

instance Constrained Signal where
    within s = and $ map f $ wchanges $ scurr s where
        f (Change _ v) = within (v, sconstr s)

-- earliest :: Signal -> Signal -> Ordering
-- earliest s1 s2 = W.earliest (scurr s1) (scurr s2)

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
    modify (add_ass a)

(.+.) :: (MonadProc PS m) => m Int -> m Int -> m Int
(.+.) a b = (+) <$> a <*> b

(.-.) :: (MonadProc PS m) => m Int -> m Int -> m Int
(.-.) a b = (-) <$> a <*> b

-- | Etracts signal's current value
val :: (MonadProc PS m) => Ptr Signal -> m Int
val r = valueAt1 <$> now <*> (scurr `liftM` deref r)

stable :: (Monad m) => Int -> m Int
stable i = return i

data Assignment = Assignment {
      acurr :: Ptr Signal
    , anext :: ProjectedWaveform
    } deriving(Show)

-- | Process State
data PS = PS {
      ptime :: Time
    , passignments :: [Assignment]
    } deriving(Show)

add_ass :: Assignment -> PS -> PS
add_ass a (PS t as) = PS t (a:as)


type ProcessHandler = VProc PS VSim ()

data Process = Process {
      pname :: String
    -- ^ The name of a process
    , phandler :: ProcessHandler
    -- ^ Returns newly-assigned signals
    }

instance Show (Process) where
    show _ = "Process <handler>"

runProcess :: Time -> Process -> VSim [Assignment]
runProcess t (Process _ h) = do
    as <- passignments <$> runVProc h (PS t [])
    liftIO $ putStrLn $ show as
    return as

