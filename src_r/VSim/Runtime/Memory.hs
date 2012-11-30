{-# LANGUAGE Rank2Types #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module VSim.Runtime.Memory where

import Control.Monad.Trans
import Control.Monad.State
import Data.IntMap as IntMap
import Data.IORef
import Text.Printf
import System.IO
import System.Random

import VSim.Runtime.Waveform
import VSim.Runtime.Process
import VSim.Runtime.Monad

class Generator x where
    type SR x :: *
    -- ^ Signal representation
    type DV x :: *
    -- ^ Default value representation
    alloc_signal :: (MonadElab m) => String -> m (DV x) -> x -> m (SR x)
    -- ^ Allocate signal for this type representation
    rnd :: (MonadElab m) => x -> m (DV x)

instance Generator Constraint where
    type SR Constraint = Ptr Signal
    type DV Constraint = Int
    alloc_signal = alloc_primitive_signal
    -- FIXME: consraints
    rnd _ = liftIO $ randomIO 

instance Generator Array where
    type SR Array = Ptr Compound
    type DV Array = ()
    alloc_signal = alloc_array_signal
    rnd _ = return ()

-- | Allocates signal from the memory
alloc_primitive_signal :: (MonadElab m) => String -> m Int -> Constraint -> m (Ptr Signal)
alloc_primitive_signal n mi c = do
    i <- mi
    r <- allocM (Signal n (wconst i) 0 c [])
    modify_mem $ \(Memory rs ps) -> Memory (r:rs) ps
    return r

-- | Allocates signal from the memory
alloc_array_signal :: (MonadElab m) => String -> m () -> Array -> m (Ptr Compound)
alloc_array_signal n _ a = do
    let indexes = [(abegin a) .. (aend a)]
    pairs <- forM indexes (\i -> do
        let sn = n ++ (printf "[%d]" i)
        s <- alloc_primitive_signal sn (return 0) (aconstr a)
        return (i,s))
    allocM (Compound n (IntMap.fromList pairs) a)

-- | Allocates variable from the memory
alloc_variable :: (MonadElab m) => String -> m Int -> Constraint -> m (Ptr Variable)
alloc_variable n mi c = mi >>= \i -> allocM (Variable n i c)

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

alloc_constant :: (MonadElab m) => String -> m Int -> m Int
alloc_constant _ v = v

alloc_ranged_type :: (MonadElab m) => Int -> Int -> m Constraint
alloc_ranged_type a b = return $ ranged a b

alloc_unranged_type :: (MonadElab m) => m Constraint
alloc_unranged_type = return unranged

alloc_array_type :: (MonadElab m) => Int -> Int -> Constraint -> m Array
alloc_array_type b e c = return $ Array c b e

printSignalsM :: (MonadIO m) => Memory -> m ()
printSignalsM m = liftIO $ mapM (printSignalM m) >=> mapM_ putStrLn $ (msignals m)

printProcessesM :: (MonadIO m) => Memory -> m ()
printProcessesM m = do
    forM_ (mprocesses m) $ \r -> do
        p <- deref m r
        liftIO $ printf "proc %s active %s\n" (pname p) (show $ pawake p)

