{-# LANGUAGE Rank2Types #-}

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
    , wnext :: Waveform
    } deriving(Show)

data Process = Process {
      name :: String
    , handler :: forall ss m . (MonadIO m, MonadReader ss m) => Time -> m [Assignment]
    -- ^ Returns newly-assigned signals
    }

instance Show Process where
    show _ = "Process <handler>"

assign :: (Monad m) => Ptr Signal -> Waveform -> m Assignment
assign p w = return $ Assignment p w

