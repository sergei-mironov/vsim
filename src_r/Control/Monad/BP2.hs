{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RankNTypes #-}

-- to write MonadState instance
{-# LANGUAGE UndecidableInstances #-}

module Control.Monad.BP2 (
      BP(..)
    -- , MonadBP(..)
    , runBP
    , retBP
    , pauseBP
    , haltBP
    , catchEarly
    ) where

import Control.Applicative
import Control.Monad.ST
import Control.Monad.Trans
import Control.Monad.Fix
import Control.Monad.State
import Text.Printf

newtype BP l s m a = BP {
    unBP :: forall r . s -> (s -> a -> m r)
                         -> (s -> l -> m r)
                         -> (s -> BP l s m a -> m r)
                         -> m r
    }

instance (Monad m) => Monad (BP l s m) where
    {-# INLINE return #-}
    return a = BP $ \s done doneC _ -> done s a
    fail msg = BP $ \_ _ _ _ -> fail msg
    {-# INLINE (>>=) #-}
    (>>=) = bindBP

{-# INLINE bindBP #-}
bindBP :: (Monad m) => BP l s m a -> (a -> BP l s m b) -> BP l s m b
bindBP ma f = BP $ \s done cdone cont -> 
    let i_done s' a = unBP (f a) s' done cdone cont
        i_cdone s' l = cdone s' l
        i_cont s' k = cont s' (bindBP k f)
    in unBP ma s i_done i_cdone i_cont

runBP :: (Monad m) => BP l s m a -> s -> m (s, Either (BP l s m a) a)
runBP bp s = unBP bp s i_done i_cdone i_cont
    where i_done s' a = return (s',Right a)
          i_cont s' k = return (s', Left k)
          i_cdone s' l = fail "runBP: unhandled C-style return"

instance (MonadIO m) => MonadIO (BP l s m) where
    liftIO = lift . liftIO

instance MonadTrans (BP l s) where
    lift m = BP $ \s done _ _ -> m >>= done s

instance (Functor m, Monad m) => Functor (BP l s m) where
    {-# INLINE fmap #-}
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

-- | Pauses execution
{-# INLINE pauseBP #-}
pauseBP :: (Monad m) => BP l s m ()
pauseBP = BP $ \s _ _ cont -> cont s (return ())

-- | Pauses execution without allowing it to continue
{-# INLINE haltBP #-}
haltBP :: (Monad m) => BP l s m ()
haltBP = BP $ \s _ _ cont -> cont s (haltBP)

-- | Returns early result
{-# INLINE retBP #-}
retBP :: (Monad m) => l -> BP l e m ()
retBP l = BP $ \s _ cdone _ -> cdone s l

{-# INLINE catchEarly #-}
catchEarly :: (Monad m) => BP l s m a -> BP x s m (Either l a)
catchEarly bp = BP $ \s done cdone cont ->
    let i_done s' a = done s' (Right a)
        i_cdone s' l = done s' (Left l)
        i_cont s' k = cont s' (catchEarly k)
    in unBP bp s i_done i_cdone i_cont

