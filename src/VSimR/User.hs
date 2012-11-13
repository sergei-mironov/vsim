{-# LANGUAGE FlexibleContexts #-}
module VSimR.User (simulate) where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.BP

import VSimR.Memory
import VSimR.Time
import VSimR.Timeline
import VSimR.Signal
import VSimR.Process
import VSimR.Ptr

untilM :: (Monad m) => s -> (s -> m (s,Bool)) -> m s
untilM s f = do
    (s', stop) <- f s
    if stop then return s' else untilM s' f

untilM_ :: (Monad m) => s -> (s -> m (s,Bool)) -> m ()
untilM_ s f = do
    (s', stop) <- f s
    if stop then return () else untilM_ s' f

simulate :: (MonadIO m) => Time -> Memory -> ss -> m ()
simulate et m ss = do
    untilM_ (time_min,(processes m)) $ \(t,ps) -> do
        as <- concat `liftM` mapM (deref >=> runProcess t ss) ps
        commit t as
        (t', ps') <- advance (signals m)
        return ((t',ps'), t >= et)

