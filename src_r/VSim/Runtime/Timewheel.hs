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
import Control.Monad.State
import Data.List as List
import Data.Maybe
import Data.Monoid
import Data.Map as Map
import Data.Set as Set
import Text.Printf

import VSim.Runtime.Monad
import VSim.Runtime.Time
import VSim.Runtime.Waveform
import VSim.Runtime.Process
import VSim.Runtime.Ptr

-- | The simulation algorithm
timewheel :: (Time, SimStep) -> VSim (NextTime, SimStep)
timewheel (t, SimStep ps q) = do
    at <- kick_processes
    -- debug $ "kick complete" ++ (show at)
    commit_assignments at
    update_signals at

    where

        -- Kick all the processes we should kick
        kick_processes = mconcat <$> mapM kick (Set.toList ps) where
            kick pr = do
                (PS _ at pp) <- runProcess pr (PS t mempty Nothing)
                case pp of
                    Just (PPsig ss) -> siglisten pr ss >> return at
                    Just (PPtime t) -> return (add_process_kick pr t at)
                    _ -> fail $ "kick_processes: bad return state: " ++ (show pp)

        -- FIXME: monitor multiple assignments, implement resolvers
        -- FIXME: for each signal, take into account the last assignment only
        commit_assignments at = do
            mapM_ sigassign1 (aas at)

        -- Calculate next event and update the memory
        -- FIXME: inefficient, loops throw all signals and processes
        update_signals at = do
            let je = Map.minViewWithKey (Map.unionWith mappend q (ats at))
            case je of
                Nothing -> do
                    return (maxBound, SimStep Set.empty q)
                Just ((t,Event ss ps), q') -> do
                    pss <- mapM (sigassign2 t) ss
                    return (t, SimStep (Set.unions (ps:pss)) q')

