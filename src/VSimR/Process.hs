{-# LANGUAGE Rank2Types #-}
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

type Signal s = Signal' (Ptr (Process s))

data Assignment s = Assignment {
      scurr :: Ptr (Signal s)
    , wnext :: ProjectedWaveform
    } deriving(Show)

type ProcessHandler s = VProc (VSim s) [Assignment s]

data Process s = Process {
      pname :: String
    , phandler :: ProcessHandler s
    -- ^ Returns newly-assigned signals
    }

instance Show (Process s) where
    show _ = "Process <handler>"

runProcess :: Time -> Process s -> VSim s [Assignment s]
runProcess t (Process _ h) = runVProc t h

assign :: (MonadProc s m) => Ptr (Signal s) -> Waveform -> m (Assignment s)
assign p w = do
    t <- ask
    return $ Assignment p (PW t w)

