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

data Memory s = Memory {
      signals :: [Ptr (Signal s)]
    , processes :: [Ptr (Process s)]
    }
    deriving(Show)

class (MonadIO m, MonadState (Memory s) m) => MonadElab s m
instance MonadElab s (StateT (Memory s) IO)
type Elab s = (StateT (Memory s) IO) s

runElab elab = runStateT elab emptyMem

emptyMem = Memory [] []

alloc_signal' :: (MonadElab s m) => (Signal s) -> m (Ptr (Signal s))
alloc_signal' s = do
    r <- alloc s
    modify $ \(Memory rs ps) -> Memory (r:rs) ps
    return r

alloc_signal :: (MonadElab s m) => Waveform -> Constraint -> m (Ptr (Signal s))
alloc_signal w c = alloc_signal' (Signal' w 0 c [])

alloc_variable' :: (MonadElab s m) => Variable -> m (Ptr Variable)
alloc_variable' v = alloc v

alloc_variable :: (MonadElab s m) => Int -> Constraint -> m (Ptr Variable)
alloc_variable v c = alloc_variable' (Variable v c)

alloc_process :: (MonadElab s m) => (ProcessHandler s) -> m (Ptr (Process s))
alloc_process h = alloc (Process "process" h)


