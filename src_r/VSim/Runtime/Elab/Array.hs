{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module VSim.Runtime.Elab.Array where

import Control.Applicative
import Control.Monad
import Text.Printf
import Data.IntMap as IntMap

import VSim.Runtime.Monad
import VSim.Runtime.Class
import VSim.Runtime.Ptr
import VSim.Runtime.Elab.Prim

-- | ArrayT of IntType generates Arrays of this type
instance (MonadElab m, Createable m x) => Createable m (ArrayT x) where
    type SR (ArrayT x) = Ptr (ArrayR (SR x))
    type VR (ArrayT x) = Ptr (ArrayR (VR x))

    alloc_signal n t f = do
        let indexes = [(abegin t) .. (aend t)]
        pairs <- forM indexes (\i -> do
            let sn = n ++ (printf "[%d]" i)
            (_,r) <- alloc_signal sn (aconstr t) id
            return (i,r))
        f $ pairM (pure t) (allocM (ArrayR n (IntMap.fromList pairs)))

    alloc_variable n t f = do
        let indexes = [(abegin t) .. (aend t)]
        pairs <- forM indexes (\i -> do
            let sn = n ++ (printf "[%d]" i)
            (_,r) <- alloc_variable sn (aconstr t) id
            return (i,r))
        f $ pairM (pure t) (allocM (ArrayR n (IntMap.fromList pairs)))

alloc_array_type :: (MonadElab m) => m Int -> m Int -> t -> m (ArrayT t)
alloc_array_type mb me t = ArrayT <$> (pure t) <*> mb <*> me

index :: (MonadPtr m) => m Int -> m (Array t a) -> m (t,a)
index mi mc = do
    (ta, ra) <- mc
    mb <- IntMap.lookup <$> mi <*> (csignals <$> (derefM ra))
    case mb of
        Nothing -> fail "index: out of range"
        (Just x) -> return (aconstr ta, x)

setidx :: (MonadPtr m) => m Int -> Assigner m (t,x) -> (Array t x) -> m (Array t x)
setidx mi f r = f (index mi (pure r)) >> return r

