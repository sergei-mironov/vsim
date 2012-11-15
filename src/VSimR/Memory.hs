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
import VSimR.Process
import VSimR.Variable
import VSimR.Ptr
import VSimR.Monad

data Memory = Memory {
      signals :: [Ptr Signal]
    , processes :: [Ptr Process]
    } deriving(Show)

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

alloc_signal :: (MonadElab m) => String -> Waveform -> Constraint -> m (Ptr Signal)
alloc_signal n w c = alloc_signal' (Signal n w 0 c [])

alloc_variable' :: (MonadElab m) => Variable -> m (Ptr Variable)
alloc_variable' v = alloc v

alloc_variable :: (MonadElab m) => String -> Int -> Constraint -> m (Ptr Variable)
alloc_variable n v c = alloc_variable' (Variable n v c)

-- | Registers the process in memory. Updates signal's reaction list
alloc_process :: (MonadElab m) => [Ptr Signal] -> ProcessHandler -> m (Ptr Process)
alloc_process ss h = do
    p <- alloc (Process "process" h)
    forM_ ss (update (addproc p))
    modify $ \(Memory rs ps) -> Memory rs (p:ps)
    return p


