{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}

module VSimR.Monad where

import Control.Monad.BP
import Control.Monad.State
import Control.Monad.Reader
import Control.Monad.Identity
import Control.Monad.Trans
import Control.Applicative

import VSimR.Time

data Severity = Low | High
    deriving(Show)

-- | A reason to pause the simulation
data Pause =
      Report Time Severity String
    | BreakHit Time Int
    deriving(Show)

-- | Main simulation monad. Supports breakpoints and IO.
newtype VSim a = VSim { unVSim :: BP Pause (StateT [Int] IO) a }
    deriving(Monad, MonadIO, Functor, Applicative)

instance MonadBP Pause VSim where
    pause = VSim . pause
    halt = VSim . halt

instance MonadState [Int] VSim where
    get = VSim $ get
    put = VSim . put

class (Applicative m, MonadIO m, MonadState [Int] m, MonadBP Pause m) => MonadSim m

instance MonadSim VSim

-- | Runs simulation monad. BPS is a list of breakpoints to stop at.
runVSim :: VSim a -> [Int] -> IO (Either (Pause,VSim a) a)
runVSim sim s = do
    (e, _) <- runStateT (runBP (unVSim sim)) s
    case e of
        Left (p,bp) -> return (Left (p,VSim bp))
        Right a -> return (Right a)

-- | Monad for process execution. Provides user with current time.
newtype VProc s m a = VProc { unProc :: StateT s m a }
    deriving (Monad, MonadIO, Functor, Applicative)

instance (Monad m) => MonadState s (VProc s m) where
    get = VProc $ get
    put = VProc . put

instance (MonadSim m) => MonadBP Pause (VProc s m) where
    pause = VProc . lift . pause
    halt =  VProc . lift . halt


class (MonadIO m, Applicative m, MonadState s m, MonadBP Pause m) => MonadProc s m

instance (MonadSim m) => MonadProc s (VProc s m)

runVProc :: (Monad m) => VProc s m () -> s -> m s
runVProc (VProc r) s = execStateT r s

terminate :: (MonadBP Pause m) => Time -> String -> m ()
terminate t s = halt $ Report t High s


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

