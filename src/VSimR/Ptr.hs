module VSimR.Ptr where

import Control.Monad.Trans
import Data.IORef
import System.IO

type Ptr x = IORef x

alloc :: (MonadIO m) => a -> m (Ptr a)
alloc a = liftIO $ newIORef a

write :: (MonadIO m) => Ptr a -> a -> m ()
write ptr a = liftIO $ writeIORef ptr a

deref :: (MonadIO m) => Ptr a -> m a
deref ptr = liftIO $ readIORef ptr

-- modify :: (MonadIO m) => (a->a) -> Ptr a -> m ()
-- modify f ptr = read ptr >>= write . f

instance Show (IORef x) where
    show _ = "Ptr"


