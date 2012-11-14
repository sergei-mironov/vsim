{-# LANGUAGE FlexibleContexts #-}
module VSimR.User (
      sim
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

step :: (Time,[Ptr Process]) -> VSim ()
step (t,ps) = concat `liftM` mapM (deref >=> runProcess t) ps >>= commit t

loop :: Time -> Memory -> VSim ()
loop et m = do
    loopM_ (time_min,(processes m)) $ \(t,ps) -> do
        step (t,ps)
        (t', ps') <- advance (signals m)
        return ((t',ps'), t >= et)

sim :: Time -> Elab () -> IO ()
sim et elab = do
    (_,m) <- runElab elab
    runVSim (loop et m) (BPS [] ())
    return ()


