{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RankNTypes #-}

-- to write MonadState instance
{-# LANGUAGE UndecidableInstances #-}

module Control.Monad.BP3 (
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

data BP' l s m a = BPret !a
                 | BPcret !l
                 | BPcont (BP l s m a)

newtype BP l s m a = BP { unBP :: s -> m (s, BP' l s m a) }

instance (Monad m) => Monad (BP l s m) where
    {-# INLINE return #-}
    return a = BP $ \s -> return (s, BPret a)
    fail msg = BP $ \_ -> fail msg
    {-# INLINE (>>=) #-}
    (>>=) (BP f) mb = BP $ \s -> do
        (s',bp) <- f s
        case bp of 
            (BPret a) -> unBP (mb a) s'
            (BPcret l) -> return (s', BPcret l)
            (BPcont k) -> return (s', BPcont (k >>= mb))

{-# INLINE runBP #-}
runBP :: (Monad m) => BP l s m a -> s -> m (s, Either (BP l s m a) a)
runBP bp s = do
    (s',bp') <- unBP bp s
    case bp' of
        BPret a -> return (s', Right a)
        BPcont k -> return (s', Left k)
        BPcret l -> fail "unhandled cret"

instance MonadTrans (BP l s) where
    lift m = BP $ \s -> m >>= \x -> return (s, BPret x)

instance (MonadIO m) => MonadIO (BP l s m) where
    liftIO = lift . liftIO

instance (Functor m, Monad m) => Functor (BP l s m) where
    fmap f bp = BP $ \s -> do
        (s',bp') <- unBP bp s
        case bp' of
            BPret a -> return (s', BPret (f a))
            BPcont k -> return (s', BPcont (fmap f k))
            BPcret l -> return (s', BPcret l)

instance (Monad m, Functor m) => Applicative (BP l s m) where
    pure = return
    mf <*> a = mf `ap` a

instance (Monad m) => MonadState s (BP l s m) where
    get = BP $ \s -> return (s, BPret s)
    put s' = BP $ \_ -> return (s', BPret ())

-- | Pauses execution
{-# INLINE pauseBP #-}
pauseBP :: (Monad m) => BP l s m ()
pauseBP = BP $ \s -> return (s, BPcont (return ()))

-- | Pauses execution without allowing it to continue
{-# INLINE haltBP #-}
haltBP :: (Monad m) => BP l s m ()
haltBP = BP $ \s -> return (s, BPcont haltBP)

-- | Returns early result
{-# INLINE retBP #-}
retBP :: (Monad m) => l -> BP l e m ()
retBP l = BP $ \s -> return (s, BPcret l)

{-# INLINE catchEarly #-}
catchEarly :: (Monad m) => BP l s m a -> BP x s m (Either l a)
catchEarly bp = BP $ \s -> do
    (s',bp') <- unBP bp s
    case bp' of
        BPret a -> return (s', BPret $ Right a)
        BPcont k -> return (s', BPcont (catchEarly k))
        BPcret l -> return (s', BPret $ Left l)

