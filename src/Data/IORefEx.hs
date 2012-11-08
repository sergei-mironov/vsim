module Data.IORefEx where

import Data.IORef
import Control.Monad.Reader
import Control.Monad.Trans

askG :: (MonadReader r m) => (r -> a) -> m a
askG f = liftM f ask

readRef :: (MonadReader r m, MonadIO m) => (r -> IORef a) -> m a
readRef f = askG f >>= liftIO . readIORef

writeRef :: (MonadReader r m, MonadIO m) => (r -> IORef a) -> a -> m ()
writeRef f x = modifyRef f $ const x

modifyRef :: (MonadReader r m, MonadIO m) => (r -> IORef a) -> (a -> a) -> m ()
modifyRef f m = askG f >>= \r -> liftIO $ modifyIORef r m

