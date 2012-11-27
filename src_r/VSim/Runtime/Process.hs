{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeSynonymInstances #-}

module VSim.Runtime.Process where

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

int :: (MonadProc m) => Int -> m Int
int = return

str :: (MonadProc m) => String -> m String
str = return

wait :: (MonadProc m) => m NextTime -> m ()
wait nt = nt >>= wait_until

-- | Assigns new constant waveform to a signal
assign :: (MonadProc m) => Ptr Signal -> (m NextTime, m Int) -> m ()
assign p (mt,mv) = do
    a <- Assignment <$> pure p <*> (PW <$> mt <*> (wconst <$> mv))
    modify (add_assignment a)

add, (.+.) :: (MonadProc m) => m Int -> m Int -> m Int
add a b = (+) <$> a <*> b
(.+.) = add

minus, (.-.) :: (MonadProc m) => m Int -> m Int -> m Int
minus a b = (-) <$> a <*> b
(.-.) = minus

greater, (.>.) :: (MonadProc m) => m Int -> m Int -> m Bool
greater a b = (>) <$> a <*> b
(.>.) = greater

greater_eq, (.>=.) :: (MonadProc m) => m Int -> m Int -> m Bool
greater_eq a b = (>=) <$> a <*> b
(.>=.) = greater_eq

eq, (.==.) :: (MonadProc m) => m Int -> m Int -> m Bool
eq a b = (==) <$> a <*> b
(.==.) = eq

iF :: (MonadProc m) => m Bool -> m () -> m () -> m ()
iF exp m1 m2 = exp >>= \ r -> if r then m1 else m2

stable :: (Monad m) => Int -> m Int
stable i = return i

