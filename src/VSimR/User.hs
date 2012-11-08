module VSimR.User where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans
import Control.Monad.Reader

import VSimR.Memory
import VSimR.Time
import VSimR.Timeline
import VSimR.Signal
import VSimR.Process
import VSimR.Ptr

-- | Step result
-- data SR = SR {
--       assigned :: [Ptr Signal]
--     }

class Simulable ss where
    elab :: (MonadIO m) => ss -> m (Memory,ss)

simRun :: (MonadIO m, Simulable ss) => Time -> ss -> m ()
simRun et ss = do
    (m, ss') <- elab ss
    runReaderT (sim_loop m et) ss'

-- | Arguments are: current_time end_time simstate
sim_loop :: (MonadIO m, Simulable ss, MonadReader ss m)
    => Memory -> Time -> m ()
sim_loop m et = do
    (t,cs,ps) <- advance (signals m)
    as <- concat `liftM` mapM (deref >=> (flip handler t)) ps
    revalidate as
    case t >= et of
        True -> return ()
        False -> sim_loop m et
 

