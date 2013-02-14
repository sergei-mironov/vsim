-- | Commad line interface helpers
module VSim.Runtime.CLI where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans
import Data.Set as Set
import Data.List as List
import Text.Printf

import VSim.Runtime.Monad
import VSim.Runtime.Waveform
import VSim.Runtime.Time
import VSim.Runtime.Ptr

printWaveform :: (Show a) => Waveform a -> String
printWaveform (Waveform cs) = concat $ List.map pc cs where
    pc (Change t c)
        | t < maxBound = printf "< %s until %d >" (show c) ((watch t) - 1)
        | otherwise = printf "< %s until inf >" (show c)

printSignalM :: (MonadIO m) => AnyPrimitiveSignal -> m String
printSignalM (AnyPrimitiveSignal v) = derefM (vr v) >>= return . printSignal (vn v)

printSignal :: (Show t) => String -> SigR t -> String
printSignal n s = printf "signal %s wave %s" n (printWaveform (swave s))

printSignalsM :: (MonadIO m) => Memory -> m ()
printSignalsM m = liftIO $ (mapM printSignalM >=> mapM_ putStrLn) $ (allSignals m)

printProcessesM :: (MonadIO m) => Memory -> m ()
printProcessesM m = do
    forM_ (Set.toList $ mprocesses m) $ \r -> do
        p <- derefM r
        liftIO $ printf "proc %s\n" (pname p)

