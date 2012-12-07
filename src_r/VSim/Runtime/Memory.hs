{-# LANGUAGE Rank2Types #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
-- {-# LANGUAGE NoMonomorphismRestriction #-}

module VSim.Runtime.Memory where

import Control.Monad.Trans
import Control.Monad.State
import Data.IntMap as IntMap
import Data.IORef
-- import Data.Paired
import Text.Printf
import System.IO
import System.Random

import VSim.Runtime.Waveform
import VSim.Runtime.Process
import VSim.Runtime.Monad

class Generator x where
    -- | Signal representation
    type SR x :: *
    -- | Default value representation
    type DV x :: *
    -- | Allocate signal for this type representation
    alloc_signal :: (MonadElab m) => String -> m (DV x) -> x -> m (SR x)
    -- | Allocate random value for this type
    rnd :: (MonadElab m) => x -> m (DV x)

instance Generator Constraint where
    type SR Constraint = Ptr Signal
    type DV Constraint = Int
    alloc_signal = alloc_primitive_signal
    rnd c = liftIO $ randomRIO (lower c, upper c)

-- | ArrayT generates Arrays
instance Generator ArrayT where
    type SR ArrayT = Ptr (Array (Ptr Signal))
    type DV ArrayT = ()
    alloc_signal = alloc_array_signal
    rnd _ = return ()

instance (Generator a, Generator b) => Generator (a,b)  where
    type SR (a,b) = (SR a, SR b)
    type DV (a,b) = (DV a, DV b)
    alloc_signal n md (ta,tb) = do
        (da,db) <- md
        sa <- alloc_signal (n++".a") (return da) ta
        sb <- alloc_signal (n++".b") (return db) tb
        return (sa,sb)
    rnd (ta,tb) = do
        da <- rnd ta
        db <- rnd tb
        return (da,db)

instance Generator ()  where
    type SR () = ()
    type DV () = ()
    alloc_signal _ _ _ = return ()
    rnd _ = return ()

newtype RecordT x = RecordT x
    deriving(Show)

instance Generator x => Generator (RecordT x) where
    type SR (RecordT x) = Ptr (Record (SR x))
    type DV (RecordT x) = (DV x)
    alloc_signal n mdef (RecordT t) = do
        d <- mdef
        t <- alloc_signal n (return d) t
        r <- allocM $ Record n t
        return r
    rnd (RecordT x) = rnd x

accessors = 
    (fst,
    (fst . snd,
    (fst . snd . snd,
    (fst . snd . snd . snd,
    (fst . snd . snd . snd . snd,
    (fst . snd . snd . snd . snd . snd,
    (fst . snd . snd . snd . snd . snd . snd,
    (fst . snd . snd . snd . snd . snd . snd . snd,
    (fst . snd . snd . snd . snd . snd . snd . snd . snd,
    (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd,
    (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd,
    (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd,
    (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd,
    (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd,
    (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd,
    (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd,
    ()))))))))))))))))

alloc_record_type x = return (RecordT x, accessors)

-- | Allocates signal from the memory
alloc_primitive_signal :: (MonadElab m) => String -> m Int -> Constraint -> m (Ptr Signal)
alloc_primitive_signal n mi c = do
    i <- mi
    r <- allocM (Signal n (wconst i) 0 c [])
    modify_mem $ \(Memory rs ps) -> Memory (r:rs) ps
    return r

-- | Allocates signal from the memory
alloc_array_signal :: (MonadElab m) => String -> m () -> ArrayT -> m (Ptr (Array (Ptr Signal)))
alloc_array_signal n _ a = do
    let indexes = [(abegin a) .. (aend a)]
    pairs <- forM indexes (\i -> do
        let sn = n ++ (printf "[%d]" i)
        s <- alloc_primitive_signal sn (return 0) (aconstr a)
        return (i,s))
    allocM (Array n (IntMap.fromList pairs) a)

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

alloc_array_type :: (MonadElab m) => Int -> Int -> Constraint -> m ArrayT
alloc_array_type b e c = return $ ArrayT c b e

printSignalsM :: (MonadIO m) => Memory -> m ()
printSignalsM m = liftIO $ mapM (printSignalM m) >=> mapM_ putStrLn $ (msignals m)

printProcessesM :: (MonadIO m) => Memory -> m ()
printProcessesM m = do
    forM_ (mprocesses m) $ \r -> do
        p <- deref m r
        liftIO $ printf "proc %s active %s\n" (pname p) (show $ pawake p)

