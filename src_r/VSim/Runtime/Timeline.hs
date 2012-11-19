module VSim.Runtime.Timeline (
      advance
    , commit
    ) where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans
import Text.Printf

import VSim.Runtime.Monad
import VSim.Runtime.Ptr
import VSim.Runtime.Time
import VSim.Runtime.Waveform
import VSim.Runtime.Process
import VSim.Runtime.Constraint

-- | Invalidate signal assignments
--
-- FIXME: monitor multiple assignments, implement resolvers
-- FIXME: return some hint on signals to process next
-- FIXME: for each signal, take only the last assignment into account
commit :: (MonadSim m) => Time -> [Assignment] -> m ()
commit t as = do
    forM_ as $ \(Assignment r pw) -> do
        s@(Signal n w o c p) <- deref r
        let s' = chwave (unPW w pw) s
        case (within s') of
            True -> write r s'
            False -> do
                let err = printf "constraint check failed: signal %s" (sname s)
                terminate t err

-- | Returns the time of the next event, as well as signals to be changed
--
-- FIXME: take waitable processes into account
next_event :: (MonadIO m) => [Ptr Signal] -> m ([(Ptr Signal,Waveform)], Time)
next_event ss = foldM cmp ([],time_max) ss where
    cmp o@(l,t) r = do
        (t', jw) <- event `liftM` scurr `liftM` deref r
        case (compare t' t, jw) of
            (LT, Just w') -> return ([(r,w')], t')
            (EQ, Just w') -> return ((r,w'):l, t)
            _ -> return o

-- | Calculates the time of next event
advance :: (MonadIO m) => [Ptr Signal] -> m (Time, [Ptr Process])
advance ss = do
    (cs,t) <- next_event ss
    ps <- forM cs $ \(r,w) -> do
        s <- deref r
        write r (chwave w s)
        return (proc s)
    return (t, concat ps)

