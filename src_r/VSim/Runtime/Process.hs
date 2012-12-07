{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeSynonymInstances #-}

-- | Module declares various process-level DSL combinators
module VSim.Runtime.Process where

import qualified Data.IntMap as IntMap
import Control.Applicative
import Control.Monad.Trans
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.BP
import Control.Monad
import Text.Printf

import VSim.Runtime.Monad
import VSim.Runtime.Time
import VSim.Runtime.Waveform

class Valueable x where
    val :: (MonadProc m) => x -> m Int

instance Valueable Int where
    val r = return r

instance Valueable (Ptr Variable) where
    val r = vval `liftM` derefM r

instance Valueable (Ptr Signal) where
    val r = valueAt1 <$> now <*> (swave `liftM` derefM r)

printSignalM :: (MonadIO m) => Memory -> Ptr Signal -> m String
printSignalM m r = deref m r >>= return . printSignal

printSignal :: Signal -> String
printSignal s = printf "signal %s wave %s" (sname s) (printWaveform (swave s))

ms :: (MonadProc m) => Int -> m NextTime
ms t = ticked <$> now <*> (pure $ t * milliSecond)

us :: (MonadProc m) => Int -> m NextTime
us t = ticked <$> now <*> (pure $ t * microSecond)

ps :: (MonadProc m) => Int -> m NextTime
ps t = ticked <$> now <*> (pure $ t * picoSecond)

ns :: (MonadProc m) => Int -> m NextTime
ns t = ticked <$> now <*> (pure $ t * nanoSecond)

fs :: (MonadProc m) => Int -> m NextTime
fs t = ticked <$> now <*> (pure $ t * femtoSecond)

next :: (MonadProc m) => m NextTime
next = fs 1

-- | Type hint for ints
int :: (Monad m) => Int -> m Int
int = return

-- | Type hint for strings
str :: (Monad m) => String -> m String
str = return

-- | Signal accessor
sig :: (Monad m) => Ptr Signal -> m (Ptr Signal)
sig = return

wait :: (MonadProc m) => m NextTime -> m ()
wait nt = nt >>= wait_until

-- | Assigns new constant waveform to a signal
assign :: (MonadProc m, Valueable x) => m (Ptr Signal) -> (m NextTime, m x) -> m ()
assign s (mt,mv) = do
    a <- Assignment <$> s <*> (PW <$> mt <*> (wconst <$> (val =<< mv)))
    modify (add_assignment a)

-- | Assigns new value to the variable
vassign :: (MonadProc m) => m (Ptr Variable) -> m Int -> m ()
vassign mv ma = do
    v' <- ma
    updateM (\(Variable n v c) -> Variable n v' c) =<< mv

add, (.+.) :: (MonadProc m, Valueable x, Valueable y) => m x -> m y -> m Int
add ma mb = (+) <$> (val =<< ma) <*> (val =<< mb)
(.+.) = add

minus, (.-.) :: (MonadProc m, Valueable x, Valueable y) => m x -> m y -> m Int
minus ma mb = (-) <$> (val =<< ma) <*> (val =<< mb)
(.-.) = minus

greater, (.>.) :: (MonadProc m, Valueable x, Valueable y) => m x -> m y -> m Bool
greater ma mb = (>) <$> (val =<< ma) <*> (val =<< mb)
(.>.) = greater

greater_eq, (.>=.) :: (MonadProc m, Valueable x, Valueable y) => m x -> m y -> m Bool
greater_eq ma mb = (>=) <$> (val =<< ma) <*> (val =<< mb)
(.>=.) = greater_eq

eq, (.==.) :: (MonadProc m, Valueable x, Valueable y) => m x -> m y -> m Bool
eq ma mb = (==) <$> (val =<< ma) <*> (val =<< mb)
(.==.) = eq

-- | Monadic if
iF :: (MonadProc m) => m Bool -> m () -> m () -> m ()
iF exp m1 m2 = exp >>= \ r -> if r then m1 else m2

data ForDirection = To | Downto
    deriving(Show)

-- | Monadic for
for :: (MonadProc m) => (m Int, ForDirection, m Int) -> (Int -> m ()) -> m ()
for (ma,dir,mb) body = do
    a <- ma
    b <- mb
    let indexes To = [a..b]
        indexes Downto = [b..a]
    forM_ (indexes dir) body

index :: (MonadProc m) => m (Ptr Compound) -> m Int -> m (Ptr Signal)
index c mi = do
    mb <- IntMap.lookup <$> mi <*> (csignals <$> (derefM =<< c))
    maybe (assert >> return (error "BUG: return after assert")) return mb

field :: (MonadProc m) => (x -> y) -> m (Ptr (Record x)) -> m y
field fsel mr = (fsel . rtuple) <$> (derefM =<< mr)

