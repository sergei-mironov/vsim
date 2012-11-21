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
signals_before' :: (MonadIO m) => Time -> [Ptr Signal] -> m (Time, [(Ptr Signal,Waveform)])
signals_before' tmax ss = foldM cmp (tmax,[]) ss where
    cmp o@(t,l) r = do
        (t', jw) <- event `liftM` scurr `liftM` deref r
        case (compare t' t, jw) of
            (LT, Just w') -> return (t', [(r,w')])
            (EQ, Just w') -> return (t, (r,w'):l)
            _ -> return o

signals_before :: (MonadIO m) => Time -> [Ptr Signal] -> m (Time, [Ptr Process])
signals_before tm ss = do
    (t,cs) <- signals_before' tm ss
    ps <- forM cs $ \(r,w) -> withPtr (\s -> (chwave w s, proc s)) r
    return (t, concat ps)

process_before :: (MonadIO m) => Time -> [Ptr Process] -> m ([Ptr Process], Time)
process_before = undefined

-- | Calculates the time of next event
advance :: (MonadIO m) => [Ptr Signal] -> m (Time, [Ptr Process])
advance ss = do
    (t,cs) <- signals_before' time_max ss
    ps <- forM cs $ \(r,w) -> do
        s <- deref r
        write r (chwave w s)
        return (proc s)
    return (t, concat ps)

