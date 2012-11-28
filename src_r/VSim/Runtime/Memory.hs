{-# LANGUAGE Rank2Types #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module VSim.Runtime.Memory where

import Control.Monad.Trans
import Control.Monad.State
import Data.IORef
import Text.Printf
import System.IO

import VSim.Runtime.Waveform
import VSim.Runtime.Process
import VSim.Runtime.Monad

runElab elab = runStateT elab emptyMem

alloc_signal' :: (MonadElab m) => Signal -> m (Ptr Signal)
alloc_signal' s = do
    r <- allocM s
    modify_mem $ \(Memory rs ps) -> Memory (r:rs) ps
    return r

-- | Allocates signal from the memory
alloc_signal :: (MonadElab m) => String -> Int -> Constraint -> m (Ptr Signal)
alloc_signal n i c = alloc_signal' (Signal n (wconst i) 0 c [])

-- | Allocates variable from the memory
alloc_variable :: (MonadElab m) => String -> Int -> Constraint -> m (Ptr Variable)
alloc_variable n v c = allocM (Variable n v c)

-- | Registers process in the memory. Updates list of signal's reactions
alloc_process :: (MonadElab m)
    => String -> [Ptr Signal] -> ProcessHandler -> m (Ptr Process)
alloc_process n ss h = do
    let encycle [] = forever h
        encycle xs = forever (h >> wait_on xs)
    p <- allocM (Process n (encycle ss) Nothing [])
    modify_mem $ \(Memory rs ps) -> Memory rs (p:ps)
    return p

alloc_process_let :: (MonadElab m)
    => String -> [Ptr Signal] -> m ProcessHandler -> m (Ptr Process)
alloc_process_let n ss lh = lh >>= alloc_process n ss

alloc_constant :: (MonadElab m) => String -> Int -> m Int
alloc_constant _ v = return v

alloc_ranged_type :: (MonadElab m) => Int -> Int -> m (Constraint)
alloc_ranged_type a b = return $ ranged a b

alloc_unranged_type :: (MonadElab m) => m (Constraint)
alloc_unranged_type = return unranged

printSignalsM :: (MonadIO m) => Memory -> m ()
printSignalsM m = liftIO $ mapM (printSignalM m) >=> mapM_ putStrLn $ (msignals m)

printProcessesM :: (MonadIO m) => Memory -> m ()
printProcessesM m = do
    forM_ (mprocesses m) $ \r -> do
        p <- deref m r
        liftIO $ printf "proc %s active %s\n" (pname p) (show $ pawake p)

