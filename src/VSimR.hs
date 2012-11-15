{-# LANGUAGE FlexibleContexts #-}

module VSimR (
      module VSimR.Process
    , module VSimR.Timeline
    , module VSimR.Time
    , module VSimR.Memory
    , module VSimR.Variable
    , module VSimR.Ptr
    , module VSimR.Waveform
    , module VSimR.Monad
    , sim
    ) where

import Control.Monad
import Control.Monad.BP
import Control.Monad.Trans

import VSimR.Process
import VSimR.Timeline
import VSimR.Time
import VSimR.Memory
import VSimR.Variable
import VSimR.Ptr
import VSimR.Waveform
import VSimR.Monad

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

