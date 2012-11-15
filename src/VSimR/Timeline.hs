module VSimR.Timeline (
      advance
    , commit
    ) where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans

import VSimR.Ptr
import VSimR.Time
import VSimR.Waveform
import VSimR.Process

-- | Returns the time of the next event, as well as signals to be changd
--
-- FIXME: take waitable processes into account
next_event :: (MonadIO m) => [Ptr Signal] -> m ([(Ptr Signal,Waveform)], Time)
next_event ss = foldM cmp ([],time_max) ss where
    cmp o@(l,t) r = do
        (Change t' _, w') <- event `liftM` wcurr `liftM` deref r
        case compare t' t of
            LT -> return ([(r,w')], t')
            EQ -> return ((r,w'):l, t)
            _ -> return o

-- | Calculates next event's time
advance :: (MonadIO m) => [Ptr Signal] -> m (Time, [Ptr Process])
advance ss = do
    (cs,t) <- next_event ss
    ps <- forM cs $ \(r,w) -> do
        s <- deref r
        write r (chwave w s)
        return (proc s)
    return (t, concat ps)

-- | Invalidate signal assignments
--
-- FIXME: monitor multiple assignments, implement resolvers
-- FIXME: return some hint on signals to process next
commit :: (MonadIO m) => Time -> [Assignment] -> m ()
commit t as = do
    forM_ as $ \(Assignment r pw) -> do
        (Signal n w o c p) <- deref r
        write r (Signal n (unPW w pw) o c p)

