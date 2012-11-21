module VSim.Runtime.Ptr where

import Control.Monad.Trans
import Data.IORef
import System.IO
import System.IO.Unsafe

type Ptr x = IORef x

alloc :: (MonadIO m) => a -> m (Ptr a)
alloc a = liftIO $ newIORef a

write :: (MonadIO m) => Ptr a -> a -> m ()
write ptr a = liftIO $ writeIORef ptr a

deref :: (MonadIO m) => Ptr a -> m a
deref ptr = liftIO $ readIORef ptr

update :: (MonadIO m) => (a->a) -> Ptr a -> m ()
update f ptr = deref ptr >>= write ptr . f

withPtr :: (MonadIO m) => (a->(a,b)) -> Ptr a -> m b
withPtr f ptr = deref ptr >>= \a -> do
    let (a',b) = f a in write ptr a' >> return b

instance (Show x) => Show (IORef x) where
    show x = "@(" ++ show (unsafePerformIO $ deref x) ++ ")"

