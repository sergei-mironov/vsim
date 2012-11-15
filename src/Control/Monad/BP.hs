{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RankNTypes #-}
-- To declera MonadState instances
{-# LANGUAGE UndecidableInstances #-}

module Control.Monad.BP where

import Control.Applicative
import Control.Monad.ST
import Control.Monad.Trans
import Control.Monad.Fix
import Control.Monad.State
import Text.Printf

class MonadBP e m where
    pause :: e -> m ()

newtype BP e m a = BP {
    unBP :: forall r . (a -> m r) -> (e -> BP e m a -> m r) -> m r
    }

instance (Monad m) => MonadBP e (BP e m) where
    pause = pauseBP

instance (Monad m) => Monad (BP e m) where
    return a = BP $ \done _ -> done a
    fail msg = BP $ \_ _ -> fail msg
    (>>=) = bindBP

bindBP :: (Monad m) => BP e m a -> (a -> BP e m b) -> BP e m b
bindBP ma f = BP $ \done cont -> 
    let i_done a = unBP (f a) done cont
        i_cont e k = cont e (bindBP k f)
    in unBP ma i_done i_cont

-- cont :: BP m a -> BP m a
-- cont bp = BP $ \_ cont -> cont bp

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

{-    

data BPS s = BPS [Int] s
    deriving (Show)

bps :: (MonadState (BPS s) m) => m [Int]
bps = get >>= \(BPS l _) -> return l

get' :: (MonadState (BPS s) m) => m s
get' = get >>= \(BPS _ s) -> return s

put' :: (MonadState (BPS s) m) => s -> m ()
put' s' = get >>= \(BPS l s) -> put (BPS l s')

modify' :: (MonadState (BPS s) m) => (s->s) -> m ()
modify' f = get >>= \(BPS l s) -> put (BPS l (f s))

loc :: (MonadState (BPS s) m) => Int -> BP m ()
loc ln = BP $ \done cont -> do
    ba <- (elem ln) `liftM` bps
    case ba of
        False -> done ()
        True -> cont (return ())
            -- undefined -- cont (BP $ \_ _ -> done ())

jumpy :: BP (StateT (BPS Int) IO) ()
jumpy = do
    modify' (+ 1)
    s <- get'
    liftIO $ putStrLn (show s)
    loc 1
    if s < 5 then jumpy else return ()

runJumpy :: BP (StateT (BPS Int) IO) a -> BPS Int -> IO a
runJumpy j s = do
    let mjs = runStateT (runBP j) s
    (js, BPS l' i') <- mjs
    case js of
        Left k -> do
            putStrLn $ "break; s = " ++ show i'
            runJumpy k (BPS [1] i')
        Right x -> return x

-}
