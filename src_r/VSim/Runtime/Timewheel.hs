{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}

module VSim.Runtime.Timewheel (
      timewheel
    ) where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans
import Data.Maybe
import Data.Monoid
import Text.Printf

import VSim.Runtime.Monad
import VSim.Runtime.Time
import VSim.Runtime.Waveform
import VSim.Runtime.Process

data ES = ES [(Ptr Signal, Waveform)] [Ptr Process]
    deriving(Show)

instance Monoid ES where
    mempty = ES mempty mempty
    mappend (ES a b) (ES x y) = ES (a`mappend`x) (b`mappend`y)

class Eventable x where
    next_event :: (MonadIO m, Applicative m, MonadMem m) => x -> m (NextTime, ES)

instance Eventable (Ptr Signal) where
    next_event r = do
        (t,w) <- event <$> swave <$> derefM r
        let es = ES [(r,w)] []
        return (t, es)

instance Eventable (Ptr Process) where
    next_event r = do
        let chk Nothing = (maxBound, ES [] [])
            chk (Just t) = (t, ES [] [r])
        (t,es) <- chk <$> pawake <$> derefM r
        return (t,es)

scan_event :: (MonadIO m, Applicative m, Eventable e, MonadMem m)
    => [e] -> (NextTime, ES) -> m (NextTime, ES)
scan_event es init = foldM cmp init es where
    cmp (t,e) x = do
        (t',e') <- next_event x
        case (compare t' t) of
            LT -> return (t', e')
            EQ -> return (t, e'`mappend`e)
            _ -> return (t,e)

-- | The simulation algorithm
timewheel :: (Time, SimStep) -> VSim (NextTime, SimStep)
timewheel (t, SimStep ps) = do
    as <- kick_processes
    commit_assignments as
    update_signals

    where

        -- Kicks all the processes from the previous step
        kick_processes = concat <$> mapM kick ps where
            kick r = do
                p <- derefM r
                ((PP ss nt, PS _ as), h') <- runVProc (phandler p) (PS t [])
                rewind r h' nt
                relink r ss
                return as

        -- FIXME: monitor multiple assignments, implement resolvers
        -- FIXME: for each signal, take only the last assignment into account
        commit_assignments as = do
            forM_ as $ \a -> do
                ok <- sigassign1 a
                case ok of
                    Left sn -> do
                        let err = printf "constraint check failed: signal %s" sn
                        terminate t err
                    Right () -> do
                        return ()

        -- Calculates next event and updates the memory
        -- FIXME: inefficient, loops throw all signals and processes
        update_signals = do
            ss <- msignals <$> get_mem
            ws <- mprocesses <$> get_mem
            (t', es@(ES ss' ps1)) <- (scan_event ss >=> scan_event ws) (maxBound, mempty)
            ps2 <- concat <$> mapM (\(r,w) -> sigassign2 r w) ss'
            return (t', SimStep (ps1`mappend`ps2))

