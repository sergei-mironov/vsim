{-# LANGUAGE Rank2Types #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE FlexibleContexts #-}

module VSimR.Process where

import Control.Monad.Trans
import Control.Monad.Reader
import Control.Monad.State

import VSimR.Monad
import VSimR.Time
import VSimR.Signal
import VSimR.Ptr
import VSimR.Waveform

type Signal = Signal' (Ptr Process)

data Assignment = Assignment {
      scurr :: Ptr Signal
    , wnext :: ProjectedWaveform
    } deriving(Show)

type ProcessHandler s = VProc (VSim s) [Assignment]

data Process s = Process {
      pname :: String
    , phandler :: ProcessHandler s
    -- ^ Returns newly-assigned signals
    }

instance Show Process where
    show _ = "Process <handler>"

runProcess :: (MonadSim s m) => Time -> Process s -> m [Assignment]
runProcess t (Process _ h) = runVProc t h

assign :: (MonadProc s m) => Ptr Signal -> Waveform -> m Assignment
assign p w = do
    t <- ask
    return $ Assignment p (PW t w)

