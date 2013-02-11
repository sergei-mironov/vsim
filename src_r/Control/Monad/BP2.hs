{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RankNTypes #-}

-- to write MonadState instance
{-# LANGUAGE UndecidableInstances #-}

module Control.Monad.BP2 (
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

class (Monad m) => MonadBP s m where
    -- | Pauses the monad, but allows it to continue
    pause :: (s->s) -> m ()
    -- | Pauses the monad without allowing it to continue
    halt :: (s->s) -> m ()

newtype BP l s m a = BP {
    unBP :: forall r . s -> (s -> a -> m r)
                         -> (s -> l -> m r)
                         -> (s -> BP l s m a -> m r)
                         -> m r
    }

instance (Monad m) => MonadBP s (BP l s m) where
    pause = pauseBP
    halt = haltBP

instance (Monad m) => Monad (BP l s m) where
    return a = BP $ \s done doneC _ -> done s a
    fail msg = BP $ \_ _ _ _ -> fail msg
    (>>=) = bindBP

bindBP :: (Monad m) => BP l s m a -> (a -> BP l s m b) -> BP l s m b
bindBP ma f = BP $ \s done cdone cont -> 
    let i_done s' a = unBP (f a) s' done cdone cont
        i_cdone s' l = cdone s' l
        i_cont s' k = cont s' (bindBP k f)
    in unBP ma s i_done i_cdone i_cont

runBP :: (Monad m) => s -> BP l s m a -> m (s, Either (BP l s m a) a)
runBP s bp = unBP bp s i_done i_cdone i_cont
    where i_done s' a = return (s',Right a)
          i_cont s' k = return (s', Left k)
          i_cdone s' l = fail "runBP: unhandled C-style return"

instance (MonadIO m) => MonadIO (BP l s m) where
    liftIO = lift . liftIO

instance MonadTrans (BP l s) where
    lift m = BP $ \s done _ _ -> m >>= done s

instance (Functor m, Monad m) => Functor (BP l s m) where
  fmap f m = BP $ \s done cdone cont ->
    let i_done s' a = done s' (f a)
        i_cdone s' l = cdone s' l
        i_cont s' k = cont s' (fmap f k)
    in unBP m s i_done i_cdone i_cont

instance (Monad m, Functor m) => Applicative (BP l s m) where
    pure = return
    mf <*> a = mf `ap` a

instance (Monad m) => MonadState s (BP l s m) where
    get = BP $ \s done _ _ -> done s s
    put s' = BP $ \_ done _ _ -> done s' ()

-- | Pauses execution with reason e
pauseBP :: (Monad m) => (s->s) -> BP l s m ()
pauseBP fs = BP $ \s _ _ cont -> cont (fs s) (return ())

-- | Pauses execution without allowing it to continue
haltBP :: (Monad m) => (s->s) -> BP l s m ()
haltBP fs = BP $ \s _ _ cont -> cont (fs s) (haltBP fs)

-- | Returns early result
earlyBP :: (Monad m) => l -> BP l e m ()
earlyBP l = BP $ \s _ cdone _ -> cdone s l

catchEarly :: (Monad m) => BP l s m a -> BP x s m (Either l a)
catchEarly bp = BP $ \s done cdone cont ->
    let i_done s' a = done s' (Right a)
        i_cdone s' l = done s' (Left l)
        i_cont s' k = cont s' (catchEarly k)
    in unBP bp s i_done i_cdone i_cont

