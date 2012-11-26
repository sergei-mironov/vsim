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

runElab elab = runStateT elab emptyMem

alloc_signal' :: (MonadElab m) => Signal -> m (Ptr Signal)
alloc_signal' s = do
    r <- allocM s
    modify_mem $ \(Memory rs ps ws) -> Memory (r:rs) ps ws
    return r

-- | Allocates signal from the memory
alloc_signal :: (MonadElab m) => String -> Int -> Constraint -> m (Ptr Signal)
alloc_signal n i c = alloc_signal' (Signal n (wconst i) 0 c [])

-- | Allocates variable from the memory
alloc_variable :: (MonadElab m) => String -> Int -> Constraint -> m (Ptr Variable)
alloc_variable n v c = allocM (Variable n v c)

-- | Registers process in the memory. Updates list of signal's reactions
alloc_process :: (MonadElab m) => String -> [Ptr Signal] -> ProcessHandler -> m (Ptr Process)
alloc_process n ss h = do
    p <- allocM (Process n h)
    forM_ ss (updateM (addproc p))
    modify_mem $ \(Memory rs ps ws) -> Memory rs (p:ps) ws
    return p

-- | Registers waitable process in the memory.
alloc_waitable :: (MonadElab m) => String -> ProcessHandler -> m (Ptr Waitable)
alloc_waitable n h = do
    w <- allocM (Waitable n Nothing h)
    modify_mem $ \(Memory rs ps ws) -> Memory rs ps (w:ws)
    return w

alloc_constant :: (MonadElab m) => String -> Int -> m Int
alloc_constant _ v = return v

alloc_ranged_type :: (MonadElab m) => Int -> Int -> m (Constraint)
alloc_ranged_type a b = return $ ranged a b

alloc_unranged_type :: (MonadElab m) => m (Constraint)
alloc_unranged_type = return unranged

printSignalsM :: (MonadIO m) => Memory -> m ()
printSignalsM m = liftIO $ mapM (printSignalM m) >=> mapM_ putStrLn $ (msignals m)

