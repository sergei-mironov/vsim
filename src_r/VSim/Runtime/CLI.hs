-- | Commad line interface helpers
module VSim.Runtime.CLI where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans
import Text.Printf

import VSim.Runtime.Monad
import VSim.Runtime.Waveform
import VSim.Runtime.Time
import VSim.Runtime.Ptr

printWaveform :: (Show a) => Waveform a -> String
printWaveform (Waveform cs) = concat $ map pc cs where
    pc (Change t c)
        | t < maxBound = printf "< %s until %d >" (show c) ((watch t) - 1)
        | otherwise = printf "< %s until inf >" (show c)

printSignalM :: (MonadIO m) => Signal -> m String
printSignalM v = derefM (vr v) >>= return . printSignal (vn v)

printSignal :: String -> SigR -> String
printSignal n s = printf "signal %s wave %s" n (printWaveform (swave s))

printSignalsM :: (MonadIO m) => Memory -> m ()
printSignalsM m = liftIO $ mapM printSignalM >=> mapM_ putStrLn $ (allSignals m)

printProcessesM :: (MonadIO m) => Memory -> m ()
printProcessesM m = do
    forM_ (mprocesses m) $ \r -> do
        p <- derefM r
        liftIO $ printf "proc %s active %s\n" (pname p) (show $ pawake p)

