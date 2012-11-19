module Control.Monad.Loop where

import Control.Monad

-- | Monadic loop helper. Runs the loop until True
loopM :: (Monad m) => s -> (s -> m (s,Bool)) -> m s
loopM s f = do
    (s', stop) <- f s
    if stop then return s' else loopM s' f

-- | Monadic loop helper. Runs the loop until True. Returns unit.
loopM_ :: (Monad m) => s -> (s -> m (s,Bool)) -> m ()
loopM_ s f = do
    (s', stop) <- f s
    if stop then return () else loopM_ s' f

