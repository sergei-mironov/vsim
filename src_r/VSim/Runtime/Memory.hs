{-# LANGUAGE Rank2Types #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}

module VSim.Runtime.Memory where

import Control.Monad.Trans
import Control.Monad.State
import Control.Applicative
import Data.IntMap as IntMap
import Data.IORef
import Text.Printf
import System.IO
import System.Random

import VSim.Runtime.Waveform
import VSim.Runtime.Process
import VSim.Runtime.Monad

class Initialisable x where
    set :: (MonadElab m) => m Int -> m x -> m x

instance Initialisable (Ptr Signal) where
    set mi mr = mr >>= \r -> mi >>= \i -> updateM (\s -> s{ swave = wconst i }) r >> return r

instance Initialisable (Ptr Variable) where
    set mi mr = mr >>= \r -> mi >>= \i -> updateM (\v -> v{ vval = i }) r >> return r

rnd' :: (MonadIO m) => Constraint -> m Int
rnd' c = liftIO $ randomRIO (lower c, upper c)

setfld :: (MonadElab m, Initialisable y) =>
    (x -> y) -> m Int -> m (Ptr (Record x)) -> m (Ptr (Record x))
setfld fs mi mr = set mi (field fs mr) >> mr

setidx :: (MonadElab m, Initialisable x) =>
    Int -> m Int -> m (Ptr (Array x)) -> m (Ptr (Array x))
setidx idx mi mr = set mi (index mr (pure idx)) >> mr

aggr :: (MonadElab m) => [m a -> m a] -> m a -> m a
aggr xs mx = Prelude.foldl (\ma f -> f ma) mx xs

class Generator x where
    -- | Signal representation
    type SR x :: *
    -- | Allocate signal for this type representation
    alloc_signal :: (MonadElab m) => String -> (m (SR x) -> m (SR x)) -> x -> m (SR x)

instance Generator Constraint where
    type SR Constraint = Ptr Signal
    alloc_signal = alloc_primitive_signal

-- | ArrayT generates Arrays
instance Generator ArrayT where
    type SR ArrayT = Ptr (Array (Ptr Signal))
    alloc_signal = alloc_array_signal

-- VHDL record field collection (like tuples)
data a :- b = a :- b
    deriving (Eq, Ord, Show)
infixr 5 :-

instance (Generator a, Generator b) => Generator ((String, a) :- b)  where
    type SR ((String, a) :- b) = (SR a, SR b)
    alloc_signal n f ((fn,ta) :- tb) = do
        sa <- alloc_signal (printf "%s.%s" n fn) id ta
        sb <- alloc_signal n id tb
        f $ return (sa, sb)

instance Generator ()  where
    type SR () = ()
    alloc_signal _ _ _ = return ()

newtype RecordT x = RecordT x
    deriving(Show)

instance Generator x => Generator (RecordT x) where
    type SR (RecordT x) = Ptr (Record (SR x))
    alloc_signal n f (RecordT t) = do
        r <- alloc_signal n id t
        f $ allocM $ Record n r

alloc_record_type x = return (RecordT x, accessors) where
    -- FIXME: Make me unsee that
    accessors
        =  (fst)
        :- (fst . snd)
        :- (fst . snd . snd)
        :- (fst . snd . snd . snd)
        :- (fst . snd . snd . snd . snd)
        :- (fst . snd . snd . snd . snd . snd)
        :- (fst . snd . snd . snd . snd . snd . snd)
        :- (fst . snd . snd . snd . snd . snd . snd . snd)
        :- (fst . snd . snd . snd . snd . snd . snd . snd . snd)
        :- (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd)
        :- (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd)
        :- (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd)
        :- (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd)
        :- (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd)
        :- (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd)
        :- (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd)

-- | Allocates signal from the memory
alloc_primitive_signal :: (MonadElab m) => String -> (m (Ptr Signal) -> m (Ptr Signal)) -> Constraint -> m (Ptr Signal)
alloc_primitive_signal n f c = do
    i <- rnd' c
    r <- f $ allocM (Signal n (wconst i) 0 c [])
    modify_mem $ \(Memory rs ps) -> Memory (r:rs) ps
    return r

-- | Allocates signal from the memory
alloc_array_signal :: (MonadElab m)
    => String
    -> (m (Ptr (Array (Ptr Signal))) -> m (Ptr (Array (Ptr Signal))))
    -> ArrayT
    -> m (Ptr (Array (Ptr Signal)))
alloc_array_signal n f a = do
    let indexes = [(abegin a) .. (aend a)]
    pairs <- forM indexes (\i -> do
        let sn = n ++ (printf "[%d]" i)
        s <- alloc_primitive_signal sn id (aconstr a)
        return (i,s))
    f $ allocM (Array n (IntMap.fromList pairs) a)

-- | Allocates variable from the memory
alloc_variable :: (MonadElab m) => String -> (m (Ptr Variable) -> m (Ptr Variable)) -> Constraint -> m (Ptr Variable)
alloc_variable n f c = rnd' c >>= \i -> f $ allocM (Variable n i c)

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

