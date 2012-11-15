module VSimR.Timeline (
      advance
    , commit
    ) where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans
import Text.Printf

import VSimR.Monad
import VSimR.Ptr
import VSimR.Time
import VSimR.Waveform
import VSimR.Process
import VSimR.Variable

-- | Returns the time of the next event, as well as signals to be changd
--
-- FIXME: take waitable processes into account
next_event :: (MonadIO m) => [Ptr Signal] -> m ([(Ptr Signal,Waveform)], Time)
next_event ss = foldM cmp ([],time_max) ss where
    cmp o@(l,t) r = do
        (Change t' _, w') <- event `liftM` scurr `liftM` deref r
        case compare t' t of
            LT -> return ([(r,w')], t')
            EQ -> return ((r,w'):l, t)
            _ -> return o

-- | Calculates next event's time
advance :: (MonadIO m) => [Ptr Signal] -> m (Time, [Ptr Process])
advance ss = do
    (cs,t) <- next_event ss
    error $ "advance: BUG: time t is zero (isn't it?) and it doesn't look good: " ++ show t
    ps <- forM cs $ \(r,w) -> do
        s <- deref r
        write r (chwave w s)
        return (proc s)
    return (t, concat ps)

-- | Invalidate signal assignments
--
-- FIXME: monitor multiple assignments, implement resolvers
-- FIXME: return some hint on signals to process next
commit :: (MonadSim m) => Time -> [Assignment] -> m ()
commit t as = do
    forM_ as $ \(Assignment r pw) -> do
        s@(Signal n w o c p) <- deref r
        case (within s) of
            True -> write r $ chwave (unPW w pw) s
            False -> do
                runtime $ printf "constraint check failed: signal %s" (sname s)

