{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}

module VSimR.Monad where

import Control.Monad.BP
import Control.Monad.State
import Control.Monad.Reader
import Control.Monad.Identity

import VSimR.Time

-- | Main simulation monad. Supports breakpoints and IO.
newtype VSim ss a = VSim { unVSim :: BP (StateT (BPS ss) IO) a }
    deriving(Monad, MonadIO)

instance MonadState ss (VSim ss) where
    get = VSim $ get >>= \(BPS _ s) -> return s
    put s' = VSim $ get >>= \(BPS l _) -> put (BPS l s')

class (MonadIO m, MonadState s m) => MonadSim s m

instance MonadSim ss (VSim ss)

runVSim :: VSim ss a -> BPS ss -> IO (Either (VSim ss a) a, BPS ss)
runVSim sim bps = do
    (e, bps) <- runStateT (runBP (unVSim sim)) bps
    case e of
        Left bp -> return (Left (VSim bp), bps)
        Right a -> return (Right a, bps)

-- | Monad for process execution. Provides user with current time.
newtype VProc m a = VProc { unProc :: ReaderT Time m a }
    deriving (Monad, MonadIO)

instance (Monad m) => MonadReader Time (VProc m) where
    ask = VProc $ ask
    local f (VProc m) = VProc $ local f m

class (MonadSim s m, MonadReader Time m) => MonadProc s m

runVProc :: (Monad m) => Time -> VProc m a -> m a
runVProc t (VProc r) = runReaderT r t

loopM :: (Monad m) => s -> (s -> m (s,Bool)) -> m s
loopM s f = do
    (s', stop) <- f s
    if stop then return s' else loopM s' f

loopM_ :: (Monad m) => s -> (s -> m (s,Bool)) -> m ()
loopM_ s f = do
    (s', stop) <- f s
    if stop then return () else loopM_ s' f

