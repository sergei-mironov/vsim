{-# LANGUAGE Rank2Types #-}
{-# LANGUAGE FlexibleContexts #-}

module VSimR.Process where

import Control.Monad.Trans
import Control.Monad.Reader

import VSimR.Time
import VSimR.Signal
import VSimR.Ptr
import VSimR.Waveform

type Signal = Signal' (Ptr Process)

data Assignment = Assignment {
      scurr :: Ptr Signal
    , wnext :: ProjectedWaveform
    } deriving(Show)

data Process = Process {
      pname :: String
    , phandler :: forall ss m . (MonadIO m, MonadReader ss m) => Time -> m [Assignment]
    -- ^ Returns newly-assigned signals
    }

instance Show Process where
    show _ = "Process <handler>"

runProcess :: (MonadIO m) => Time -> ss -> Process -> m [Assignment]
runProcess t ss p = runReaderT ((phandler p) t) ss

assign :: (Monad m, MonadReader Time m) => Ptr Signal -> Waveform -> m Assignment
assign p w = do
    t <- ask
    return $ Assignment p (PW t w)

