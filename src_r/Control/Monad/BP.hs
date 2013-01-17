{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RankNTypes #-}

-- to write MonadState instance
{-# LANGUAGE UndecidableInstances #-}

module Control.Monad.BP (
      BP(..)
    , MonadBP(..)
    , runBP
    , earlyBP
    , catchEarly
    ) where

import Control.Applicative
import Control.Monad.ST
import Control.Monad.Trans
import Control.Monad.Fix
import Control.Monad.State
import Text.Printf

class (Monad m) => MonadBP e m where
    -- | Pauses the monad, but allows it to continue
    pause :: e -> m ()
    -- | Pauses the monad without allowing it to continue
    halt :: e -> m ()

newtype BP l e m a = BP {
    unBP :: forall r . (a -> m r) -> (Either e l -> BP l e m a -> m r) -> m r
    }

instance (Monad m) => MonadBP e (BP l e m) where
    pause = pauseBP
    halt = haltBP

instance (Monad m) => Monad (BP l e m) where
    return a = BP $ \done _ -> done a
    fail msg = BP $ \_ _ -> fail msg
    (>>=) = bindBP

bindBP :: (Monad m) => BP l e m a -> (a -> BP l e m b) -> BP l e m b
bindBP ma f = BP $ \done cont -> 
    let i_done a = unBP (f a) done cont
        i_cont e k = cont e (bindBP k f)
    in unBP ma i_done i_cont

runBP :: (Monad m) => BP l e m a -> m (Either (e, BP l e m a) a)
runBP bp = unBP bp i_done i_cont
    where i_done a = return (Right a)
          i_cont (Left e) k = return (Left (e,k))
          i_cont (Right l) k = fail "unhandled early result"

instance (MonadIO m) => MonadIO (BP l e m) where
    liftIO = lift . liftIO

instance MonadTrans (BP l e) where
    lift m = BP $ \done _ -> m >>= done

instance (Functor m, Monad m) => Functor (BP l e m) where
  fmap f m = BP $ \done cont ->
    let i_done a = done (f a)
        i_cont e k = cont e (fmap f k)
    in unBP m i_done i_cont

instance (Monad m, Functor m) => Applicative (BP l e m) where
    pure = return
    mf <*> a = mf `ap` a

instance (MonadState s m) => MonadState s (BP l e m) where
    get = lift $ get
    put = lift . put

-- | Pauses execution with reason e
pauseBP :: (Monad m) => e -> BP l e m ()
pauseBP e = BP $ \_ cont -> cont (Left e) (return ())

-- | Pauses execution without allowing it to continue
haltBP :: (Monad m) => e -> BP l e m ()
haltBP e = BP $ \_ cont -> cont (Left e) (haltBP e)

-- | Returns early result
earlyBP :: (Monad m) => l -> BP l e m ()
earlyBP l = BP $ \_ cont -> cont (Right l) (earlyBP l)

catchEarly :: (Monad m) => BP l e m l -> BP x e m l
catchEarly bp = BP $ \done cont ->
    let i_done a = done a
        i_cont (Left e) k = cont (Left e) (catchEarly k)
        i_cont (Right l) _ = done l
    in unBP bp i_done i_cont


