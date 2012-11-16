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

import Control.Applicative
import Control.Monad
import Control.Monad.BP
import Control.Monad.Trans
import Text.Printf
import System.IO

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
    loopM_ (time_min,(mprocesses m)) $ \(t,ps) -> do
        step (t,ps)
        (t', ps') <- advance (msignals m)
        return ((t',ps'), t >= et)

askBreak :: IO Bool
askBreak = hGetChar stdin >>= filter where
    filter c | c `elem` "yYqQ" = return True
             | c == '\n' = askBreak
             | otherwise = return False

sim' :: Memory -> VSim () -> IO ()
sim' m k = do
    e <- runVSim k []
    case e of
        Right () -> do
            return ()
        Left (Report t Low msg,k') -> do
            printf "report: time %d text %s\n" t msg
            sim' m k'
        Left (Report t High msg,_) -> do
            printf "assert: time %d text %s\n" t msg
            return ()
        Left (BreakHit t b,k') -> do
            printf "breakoiunt: time %d id %d\n" t b
            printSignalsM m
            b <- askBreak
            if b then return () else (sim' m k')

sim :: Time -> Elab () -> IO ()
sim et elab = do
    hSetBuffering stdout NoBuffering
    hSetBuffering stdin NoBuffering
    (_,m) <- runElab elab
    sim' m (loop et m)
