{-# LANGUAGE FlexibleContexts #-}
module VSimR.User (
      simulate
    ) where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.BP

import VSimR.Monad
import VSimR.Memory
import VSimR.Time
import VSimR.Timeline
import VSimR.Signal
import VSimR.Process
import VSimR.Ptr

step :: (MonadSim s m) => (Time,[Ptr Process]) -> m ()
step (t,ps) = concat `liftM` mapM (deref >=> runProcess t) ps >>= commit t

simulate :: (MonadSim s m) => Time -> Memory -> m ()
simulate et m = do
    loopM_ (time_min,(processes m)) $ \(t,ps) -> do
        step (t,ps)
        (t', ps') <- advance (signals m)
        return ((t',ps'), t >= et)

runSim :: Time -> Elab ss -> IO ()
runSim et elab = do
    (ss,m) <- runElab elab
    runVSim (simulate et m) (BPS [] ss)
    return ()


