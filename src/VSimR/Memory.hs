{-# LANGUAGE FlexibleContexts #-}
module VSimR.Memory where

import Control.Monad.Trans
import Control.Monad.State
import Data.IORef
import System.IO

import VSimR.Waveform
import VSimR.Signal
import VSimR.Process
import VSimR.Variable
import VSimR.Ptr

data Memory = Memory {
      signals :: [Ptr Signal]
    , processes :: [Ptr Process]
    }
    deriving(Show)

emptyMem = Memory [] []

alloc_signal :: (MonadIO m, MonadState Memory m) => Signal -> m (Ptr Signal)
alloc_signal s = do
    r <- alloc s
    modify $ \(Memory rs ps) -> Memory (r:rs) ps
    return r

alloc_variable :: (MonadIO m) => Variable -> m (Ptr Variable)
alloc_variable v = alloc v

