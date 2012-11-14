{-# LANGUAGE Rank2Types #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
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
import VSimR.Monad

data Memory = Memory {
      signals :: [Ptr Signal]
    , processes :: [Ptr Process]
    }
    deriving(Show)

class (MonadIO m, MonadState Memory m) => MonadElab m
instance MonadElab (StateT Memory IO)
type Elab s = (StateT Memory IO) s

runElab elab = runStateT elab emptyMem

emptyMem = Memory [] []

alloc_signal' :: (MonadElab m) => Signal -> m (Ptr Signal)
alloc_signal' s = do
    r <- alloc s
    modify $ \(Memory rs ps) -> Memory (r:rs) ps
    return r

alloc_signal :: (MonadElab m) => Waveform -> Constraint -> m (Ptr Signal)
alloc_signal w c = alloc_signal' (Signal' w 0 c [])

alloc_variable' :: (MonadElab m) => Variable -> m (Ptr Variable)
alloc_variable' v = alloc v

alloc_variable :: (MonadElab m) => Int -> Constraint -> m (Ptr Variable)
alloc_variable v c = alloc_variable' (Variable v c)

alloc_process :: (MonadElab m) => ProcessHandler -> m (Ptr Process)
alloc_process h = alloc (Process "process" h)


