{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RankNTypes #-}
-- To declare MonadState instances
{-# LANGUAGE UndecidableInstances #-}

module Control.Monad.BP (
      BP(..)
    , MonadBP(..)
    , runBP
    ) where

import Control.Applicative
import Control.Monad.ST
import Control.Monad.Trans
import Control.Monad.Fix
import Control.Monad.State
import Text.Printf

class MonadBP e m where
    pause :: e -> m ()
    halt :: e -> m ()

newtype BP e m a = BP {
    unBP :: forall r . (a -> m r) -> (e -> BP e m a -> m r) -> m r
    }

instance (Monad m) => MonadBP e (BP e m) where
    pause = pauseBP
    halt = haltBP

instance (Monad m) => Monad (BP e m) where
    return a = BP $ \done _ -> done a
    fail msg = BP $ \_ _ -> fail msg
    (>>=) = bindBP

bindBP :: (Monad m) => BP e m a -> (a -> BP e m b) -> BP e m b
bindBP ma f = BP $ \done cont -> 
    let i_done a = unBP (f a) done cont
        i_cont e k = cont e (bindBP k f)
    in unBP ma i_done i_cont

runBP :: (Monad m) => BP e m a -> m (Either (e, BP e m a) a)
runBP bp = unBP bp i_done i_cont
    where i_done a = return (Right a)
          i_cont e k = return (Left (e,k))

instance (MonadIO m) => MonadIO (BP e m) where
    liftIO = lift . liftIO

instance MonadTrans (BP e) where
    lift m = BP $ \done _ -> m >>= done

instance MonadState s m => MonadState s (BP e m) where
    get = lift get
    put a = lift $ put a

instance (Functor m, Monad m) => Functor (BP e m) where
  fmap f m = BP $ \done cont ->
    let i_done a = done (f a)
        i_cont e k = cont e (fmap f k)
    in unBP m i_done i_cont

instance (Monad m, Functor m) => Applicative (BP e m) where
    pure = return
    mf <*> a = mf `ap` a

-- | Pauses execution with reason e
pauseBP :: (Monad m) => e -> BP e m ()
pauseBP e = BP $ \_ cont -> cont e (return ())

-- | Pauses execution without allowing it to continue
haltBP :: (Monad m) => e -> BP e m ()
haltBP e = BP $ \_ cont -> cont e (haltBP e)
