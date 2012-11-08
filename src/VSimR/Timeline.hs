module VSimR.Timeline where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans

import VSimR.Ptr
import VSimR.Time
import VSimR.Signal
import VSimR.Waveform
import VSimR.Process

-- | Select signals to change
--
-- TODO: take waitable processes into account
next_event :: (MonadIO m) => [Ptr Signal] -> m ([(Ptr Signal,Waveform)], Time)
next_event ss = foldM cmp ([],time_max) ss where
    cmp o@(l,t) r = do
        (Change t' c, w) <- event `liftM` wcurr `liftM` deref r
        case compare t' t of
            LT -> return ([(r,w)], t'+1)
            EQ -> return ((r,w):l, t)
            _ -> return o

-- | Trims signal's waveform
advance :: (MonadIO m) => [Ptr Signal] -> m (Time, [Ptr Signal], [Ptr Process])
advance ss = do
    (cs,t) <- next_event ss
    ps <- forM cs $ \(r,w) -> do
            s <- deref r
            write r (chwave w s)
            return (proc s)
    return (t, map fst cs, concat ps)
        

-- | Invalidate assignments
revalidate :: (MonadIO m) => [Assignment] -> m ()
revalidate = undefined




