{-# LANGUAGE FlexibleContexts #-}

module VSim.Runtime (
      module VSim.Runtime.Process
    , module VSim.Runtime.Time
    , module VSim.Runtime.Elab
    , module VSim.Runtime.Waveform
    , module VSim.Runtime.Monad
    , module VSim.Runtime.Class
    , module VSim.Runtime.CLI
    , module Control.Applicative
    , module Data.NestedTuple
    , sim
    ) where

import Control.Applicative
import Control.Monad
import Control.Monad.BP
import Control.Monad.Trans
import Data.NestedTuple
import Text.Printf
import System.IO

import VSim.Runtime.Process
import VSim.Runtime.Timewheel
import VSim.Runtime.Time
import VSim.Runtime.Elab
import VSim.Runtime.Waveform
import VSim.Runtime.Monad
import VSim.Runtime.Class
import VSim.Runtime.Ptr
import VSim.Runtime.CLI

askBreak :: IO Bool
askBreak = hGetChar stdin >>= filter where
    filter c | c `elem` "yYqQ" = return True
             | c == '\n' = askBreak
             | otherwise = return False

sim' :: Memory -> VSim () -> IO ()
sim' m k = do
    e <- runVSim k (m,[])
    case e of
        Right () -> do
            printf "end-of-sim\n"
            return ()
        Left (Report t Low msg, m', k') -> do
            printf "report: time %d text %s\n" (watch t) msg
            sim' m' k'
        Left (Report t High msg, m', _) -> do
            printf "assert: time %d text %s\n" (watch t) msg
            return ()
        Left (BreakHit t b, m', k') -> do
            printf "breakpoint: time %d id %d\n" (watch t) b
            printSignalsM m'
            b <- askBreak
            if b then return () else (sim' m' k')

loop :: NextTime -> (Time,SimStep) -> VSim ()
loop et (t,e) = do
    (nt,e') <- timewheel (t,e)
    case move_time nt et of
        Just t' -> loop et (t',e')
        Nothing -> return ()

-- | Run the simulation until stop time @et using elaboration function @elab
sim :: NextTime -> Elab IO () -> IO ()
sim et elab = do
    hSetBuffering stdout NoBuffering
    hSetBuffering stdin NoBuffering
    (_,m) <- runElab elab
    sim' m (loop et (start_step m))

