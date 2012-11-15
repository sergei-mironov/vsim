{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}

module VSimR.Monad where

import Control.Monad.BP
import Control.Monad.State
import Control.Monad.Reader
import Control.Monad.Identity
import Control.Applicative

import VSimR.Time

-- | Main simulation monad. Supports breakpoints and IO.
newtype VSim a = VSim { unVSim :: BP (StateT (BPS ()) IO) a }
    deriving(Monad, MonadIO, Functor, Applicative)

instance MonadState () VSim where
    get = VSim $ get >>= \(BPS _ s) -> return s
    put s' = VSim $ get >>= \(BPS l _) -> put (BPS l s')

class (Applicative m, MonadIO m, MonadState () m) => MonadSim m

instance MonadSim VSim

-- | Runs simulation monad. BPS is a list of breakpoints to stop at.
runVSim :: VSim a -> BPS () -> IO (Either (VSim a) a, BPS ())
runVSim sim bps = do
    (e, bps) <- runStateT (runBP (unVSim sim)) bps
    case e of
        Left bp -> return (Left (VSim bp), bps)
        Right a -> return (Right a, bps)

-- | Monad for process execution. Provides user with current time.
newtype VProc m a = VProc { unProc :: ReaderT Time m a }
    deriving (Monad, MonadIO, Functor, Applicative)

instance (Monad m) => MonadReader Time (VProc m) where
    ask = VProc $ ask
    local f (VProc m) = VProc $ local f m

class (Applicative m, MonadIO m, MonadReader Time m) => MonadProc m

instance (MonadSim m) => MonadProc (VProc m)

runVProc :: (Monad m) => Time -> VProc m a -> m a
runVProc t (VProc r) = runReaderT r t

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

