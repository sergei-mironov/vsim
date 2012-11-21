{-# LANGUAGE FlexibleContexts #-}

module VSim.Runtime (
      module VSim.Runtime.Process
    , module VSim.Runtime.Timeline
    , module VSim.Runtime.Time
    , module VSim.Runtime.Memory
    , module VSim.Runtime.Ptr
    , module VSim.Runtime.Waveform
    , module VSim.Runtime.Monad
    , module VSim.Runtime.Constraint
    , sim
    ) where

import Control.Applicative
import Control.Monad
import Control.Monad.BP
import Control.Monad.Trans
import Control.Monad.Loop
import Text.Printf
import System.IO

import VSim.Runtime.Process
import VSim.Runtime.Timeline
import VSim.Runtime.Time
import VSim.Runtime.Memory
import VSim.Runtime.Ptr
import VSim.Runtime.Waveform
import VSim.Runtime.Monad
import VSim.Runtime.Constraint

process :: (Time,[Ptr Process]) -> VSim [Assignment]
process (t,ps) = concat `liftM` mapM (deref >=> runProcess t) ps

-- FIXME: inefficient algorithm - loop throw all signals in memory (see
-- advance function call)
loop :: Time -> Memory -> VSim ()
loop et m = do
    loopM_ (time_min,(mprocesses m)) $ \(t,ps) -> do
        ass <- process (t,ps)
        hint <- commit t ass
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
            printf "breakpoint: time %d id %d\n" t b
            printSignalsM m
            b <- askBreak
            if b then return () else (sim' m k')

-- | Run the simulation until stop time @et using elaboration function @elab
sim :: Time -> Elab () -> IO ()
sim et elab = do
    hSetBuffering stdout NoBuffering
    hSetBuffering stdin NoBuffering
    (_,m) <- runElab elab
    sim' m (loop et m)

