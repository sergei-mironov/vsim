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

class (MonadIO m, Applicative m) => MonadPtr m
instance MonadPtr IO
instance MonadPtr m => MonadPtr (StateT s m)
instance MonadPtr m => MonadPtr (ReaderT r m)
instance MonadPtr m => MonadPtr (BP l e m)

allocM :: (MonadIO m) => a -> m (Ptr a)
allocM a = liftIO (newIORef a)

writeM :: (MonadIO m) => Ptr a -> a -> m ()
writeM ptr a = liftIO (writeIORef ptr a)

derefM :: (MonadIO m) => Ptr a -> m a
derefM ptr = liftIO $ readIORef ptr

derefM' :: (MonadIO m) => Ptr a -> m (Ptr a, a)
derefM' r = derefM r >>= \v -> return (r,v)

updateM :: (MonadIO m) => (a->a) -> Ptr a -> m ()
updateM f ptr = derefM ptr >>= writeM ptr . f

withPtrM :: (MonadIO m) => (a->(a,b)) -> Ptr a -> m b
withPtrM f ptr = derefM ptr >>= \a -> do
    let (a',b) = f a in writeM ptr a' >> return b

instance (Show x) => Show (IORef x) where
    show x = "@(" ++ show (unsafePerformIO $ derefM x) ++ ")"

-- instance (MonadPtr m, Cloneable m x) => Cloneable m (Ptr x) where
--     clone r = derefM r >>= clone >>= allocM

