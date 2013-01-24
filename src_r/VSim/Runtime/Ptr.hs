{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module VSim.Runtime.Ptr where

import Control.Applicative
import Control.Monad.Trans
import Control.Monad.State
import Control.Monad.Reader
import Control.Monad.BP
import Data.IORef
import Text.Printf
import System.IO
import System.IO.Unsafe
import VSim.Runtime.Class

-- | Pointer type used everywhere in the simulator
type Ptr x = IORef x

class (MonadIO m, Applicative m, Functor m) => MonadPtr m
instance MonadPtr IO
instance MonadPtr m => MonadPtr (StateT s m)
instance MonadPtr m => MonadPtr (ReaderT r m)
instance MonadPtr m => MonadPtr (BP l e m)

allocM :: (MonadIO m) => a -> m (Ptr a)
allocM a = liftIO $ newIORef a

writeM :: (MonadIO m) => Ptr a -> a -> m ()
writeM ptr a = liftIO (writeIORef ptr a)

derefM :: (MonadIO m) => Ptr a -> m a
derefM ptr = liftIO $ readIORef ptr

maybeDerefM :: (MonadIO m) => m b -> (a -> Maybe b) -> Ptr a -> m b
maybeDerefM fail f r = derefM r >>= check . f where
    check (Just b) = return b
    check (Nothing) = fail

updateM :: (MonadIO m) => (a->a) -> Ptr a -> m ()
updateM f ptr = derefM ptr >>= writeM ptr . f

withPtrM :: (MonadIO m) => (a->(a,b)) -> Ptr a -> m b
withPtrM f ptr = derefM ptr >>= \a -> do
    let (a',b) = f a in writeM ptr a' >> return b

-- unsafe!!
withM :: (MonadIO m) => Ptr r -> (r -> m r) -> m ()
withM r f = derefM r >>= f >>= writeM r 

maybeUpdateM :: (MonadIO m) => m () -> (a->Maybe a) -> Ptr a -> m ()
maybeUpdateM fail f ptr = derefM ptr >>= check . f where
    check (Just a) = writeM ptr a
    check (Nothing) = fail

instance (Show x) => Show (IORef x) where
    show x = "@(" ++ show (unsafePerformIO $ derefM x) ++ ")"

