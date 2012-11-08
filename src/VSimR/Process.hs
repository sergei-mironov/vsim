{-# LANGUAGE Rank2Types #-}

module VSimR.Process where

import Control.Monad.Trans
import Control.Monad.Reader

import VSimR.Time

data Process = Process {
      name :: String
    , handler :: forall ss m . (MonadIO m, MonadReader ss m) => Time -> m ()
    }

instance Show Process where
    show _ = "Process <handler>"

