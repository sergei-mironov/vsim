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

import Control.Concurrent.ParallelIO

import Data.List as List
import Data.List.Split
import Data.Set as Set
import Data.Maybe
import Data.Monoid
import Data.Set as Set
import Text.Printf

import VSim.Runtime.Monad
import VSim.Runtime.Time
import VSim.Runtime.Waveform
import VSim.Runtime.Process
import VSim.Runtime.Ptr

data Event = Event {-# UNPACK #-} !NextTime [AnyPrimitiveSignal] (Set.Set (Ptr Process))
    deriving(Show)

instance Eq Event where
    (==) (Event t1 _ _) (Event t2 _ _) = t1 == t2

instance Ord Event where
    compare (Event t1 _ _) (Event t2 _ _) = t1 `compare`t2

eunion (Event t1 a1 b1) (Event t2 a2 b2)
    | t1 == t2 = Event t1 (a1`mappend`a2) (b1`mappend`b2)
    | otherwise = error "eunion: can't append events which are not simultanious"

very_last_event = Event maxBound mempty mempty

scan_event_par :: (MonadPtr m) => [[AnyPrimitiveSignal]] -> [Ptr Process] -> m Event
scan_event_par ss ps = liftIO $ do
    es <- parallel (List.map (\s -> scan_event (to_events s) very_last_event) ss)
    e <- scan_event ((to_events ps) ++ (List.map return es)) very_last_event
    return e

-- | Means that an Event could be extracted from x
class Eventable x where
    to_event :: (MonadPtr m) => x -> m Event

to_events xs = List.map to_event xs

instance Eventable AnyPrimitiveSignal where
    to_event s@(AnyPrimitiveSignal v) = do
        (t,_) <- event <$> swave <$> derefM (vr v)
        return (Event t [s] mempty)

instance Eventable (Ptr Process) where
    to_event r = chk <$> pawake <$> derefM r where
        chk Nothing  = Event maxBound [] mempty
        chk (Just t) = Event t [] (Set.singleton r)

scan_event :: (MonadPtr m) => [m Event] -> Event -> m Event
scan_event es init = foldM cmp init es where
    cmp e mx = mx >>= \e' -> (case (compare e' e) of
                                LT -> return e'
                                EQ -> return (eunion e' e)
                                _ -> return e)


-- | The simulation algorithm
timewheel :: (Time, SimStep) -> VSim (NextTime, SimStep)
timewheel (t, SimStep ps) = do
    as <- kick_processes
    commit_assignments as
    update_signals

    where

        -- Kicks all the processes from the previous step
        kick_processes = concat <$> mapM kick (Set.toList ps) where
            kick r = do
                p <- derefM r
                (PS _ as (Just (PP ss nt)), h') <- runVProc (phandler p) (PS t [] Nothing)
                liftPtr $ do
                    rewind r h' nt
                    relink r ss
                    return as

        -- FIXME: monitor multiple assignments, implement resolvers
        -- FIXME: for each signal, take only the last assignment into account
        commit_assignments as = liftPtr $ mapM_ sigassign1 as

        -- Calculates next event and updates the memory
        -- FIXME: inefficient, loops throw all signals and processes
        update_signals = do
            m <- get_mem
            ss <- uniqSignals <$> get_mem
            sss <- muniqsignals <$> get_mem
            ws <- mprocesses <$> get_mem
            liftPtr $ do
                -- (Event t' ss' ps) <- scan_event_par (chunksOf 20 (uniqSignals m)) ws
                (Event t' ss' ps) <- (scan_event (to_events ss) >=>
                                      scan_event (to_events ws)) very_last_event
                pss <- mapM (\(AnyPrimitiveSignal v) -> sigassign2 v) ss'
                return (t', SimStep (Set.unions (ps:pss)))

