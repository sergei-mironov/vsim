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

import VSim.Runtime.Ptr
import VSim.Runtime.Monad
import VSim.Runtime.Time
import VSim.Runtime.Ptr
import VSim.Runtime.Waveform
import VSim.Runtime.Constraint

printSignalM :: (MonadIO m) => Memory -> Ptr Signal -> m String
printSignalM m r = deref m r >>= return . printSignal

printSignal :: Signal -> String
printSignal s = printf "signal %s wave %s" (sname s) (printWaveform (scurr s))

-- ps_mem :: (MonadProc m) => m Memory
-- ps_mem = get >>= \(PS _ _ m) -> return m

-- derefP r = ps_mem >>= \m-> deref m r

ms :: (MonadProc m) => Int -> m NextTime
ms t = ticked <$> now <*> (tweak $ t * milliSecond)

us :: (MonadProc m) => Int -> m NextTime
us t = ticked <$> now <*> (tweak $ t * microSecond)

ps :: (MonadProc m) => Int -> m NextTime
ps t = ticked <$> now <*> (tweak $ t * picoSecond)

ns :: (MonadProc m) => Int -> m NextTime
ns t = ticked <$> now <*> (tweak $ t * nanoSecond)

fs :: (MonadProc m) => Int -> m NextTime
fs t = ticked <$> now <*> (tweak $ t * femtoSecond)

int :: (MonadProc m) => Int -> m Int
int = return

str :: (MonadProc m) => String -> m String
str = return

-- | Tweaks time for 'after' clause
--
-- VHDL standatd says:
-- > If the after clause of a waveform element is not present, then an
-- > implicit “after 0 ns” is assumed.
--
-- So "after 0 fs" means "next delta-cycle" and "after 1 fs" means "next
-- delta-cycle" since our delta cycle is 1 fs. So we have to substract 1 cycle
-- from 'after' time @t@ if it is greater then current time @n@.
tweak :: (Monad m) => Int -> m Int
tweak n | n <= 0  = return n
        | n > 0 = return $ n-1

-- | Assigns new constant waveform to a signal
assign :: (MonadProc m) => Ptr Signal -> (m Time, m Int) -> m ()
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

runProcess :: Time -> Process -> VSim [Assignment]
runProcess t p@(Process _ h) = do
    e <- runVProc h (PS t [])
    case e of
        Left _ -> error "runProcess: BUG: wait incide non-waitable process??"
        Right (PS _ as) -> return as

runWaitable :: Time -> (x,Waitable) -> VSim ([Assignment], (x,Waitable))
runWaitable t (x,Waitable n (Just (_,k)) h) = do
    e <- runVProc k (PS t [])
    case e of
        Left ((t',PS _ as), k') -> return (as, (x,Waitable n (Just (t',k')) h))
        Right (PS _ as) -> return (as, (x,Waitable n Nothing h))

runWaitable t (x,Waitable n Nothing h) = do
    e <- runVProc h (PS t [])
    case e of
        Left ((t', PS _ as), k') -> return (as, (x,Waitable n (Just (t',k')) h))
        Right (PS _ as) -> return (as, (x,Waitable n Nothing h))




