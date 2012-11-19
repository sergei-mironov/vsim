{-# LANGUAGE Rank2Types #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module VSim.Runtime.Memory where

import Control.Monad.Trans
import Control.Monad.State
import Data.IORef
import System.IO

import VSim.Runtime.Waveform
import VSim.Runtime.Process
import VSim.Runtime.Ptr
import VSim.Runtime.Monad
import VSim.Runtime.Constraint

data Memory = Memory {
      msignals :: [Ptr Signal]
    , mprocesses :: [Ptr Process]
    } deriving(Show)

class (MonadIO m, MonadState Memory m) => MonadElab m
instance MonadElab (StateT Memory IO)
type Elab s = (StateT Memory IO) s

runElab elab = runStateT elab emptyMem

emptyMem :: Memory
emptyMem = Memory [] []

alloc_signal' :: (MonadElab m) => Signal -> m (Ptr Signal)
alloc_signal' s = do
    r <- alloc s
    modify $ \(Memory rs ps) -> Memory (r:rs) ps
    return r

-- | Allocates signal from the memory
alloc_signal :: (MonadElab m) => String -> Int -> Constraint -> m (Ptr Signal)
alloc_signal n i c = alloc_signal' (Signal n (wconst i) 0 c [])

-- | Allocates variable from the memory
alloc_variable :: (MonadElab m) => String -> Int -> Constraint -> m (Ptr Variable)
alloc_variable n v c = alloc (Variable n v c)

-- | Registers process in memory. Updates list of signal's reactions
alloc_process :: (MonadElab m) => [Ptr Signal] -> ProcessHandler -> m (Ptr Process)
alloc_process ss h = do
    p <- alloc (Process "process" h)
    forM_ ss (update (addproc p))
    modify $ \(Memory rs ps) -> Memory rs (p:ps)
    return p

alloc_ranged_type :: (MonadElab m) => Int -> Int -> m (Constraint)
alloc_ranged_type a b = return $ ranged a b

alloc_unranged_type :: (MonadElab m) => m (Constraint)
alloc_unranged_type = return unranged

printSignalsM :: (MonadIO m) => Memory -> m ()
printSignalsM m = liftIO $ mapM printSignalM >=> mapM_ putStrLn $ (msignals m)

