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

printWaveform :: Waveform -> String
printWaveform (Waveform cs) = concat $ map pc cs where
    pc (Change t c)
        | t < maxBound = printf "< %d until %d >" c ((watch t) - 1)
        | otherwise = printf "< %d until inf >" c

printSignalM :: (MonadIO m) => Memory -> Ptr Signal -> m String
printSignalM m r = derefM r >>= return . printSignal

printSignal :: Signal -> String
printSignal s = printf "signal %s wave %s" (sname s) (printWaveform (swave s))

printSignalsM :: (MonadIO m) => Memory -> m ()
printSignalsM m = liftIO $ mapM (printSignalM m) >=> mapM_ putStrLn $ (msignals m)

printProcessesM :: (MonadIO m) => Memory -> m ()
printProcessesM m = do
    forM_ (mprocesses m) $ \r -> do
        p <- derefM r
        liftIO $ printf "proc %s active %s\n" (pname p) (show $ pawake p)

