module VSimR.User where

import VSimR.Memory
import VSimR.Time
import VSimR.Timeline
import VSimR.Process

-- | Step result
data SR = SR {
      assigned :: [Ptr Signal]
    }

class Simulable ss where
    elab :: (MonadIO m) => m (Memory,ss)

simRun :: (MonadIO m, Simulable ss) => Time -> m ()
simRun et = do
    (m, ss') <- elab
    sim_loop m et ss'
    
-- | Arguments are: current_time end_time simstate
sim_loop :: (MonadIO m, Simulable ss) => Memory -> Time -> ss -> m ()
sim_loop m et ss = do
    (cs,t) <- next_event (signals m)
    case t >= et of
        True -> return ()
        False -> do
            ps <- advance cs t
            mapM_ handler ps
            sim_loop m et ss

