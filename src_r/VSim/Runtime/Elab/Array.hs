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

unpack_range :: (Monad m) => RangeT -> m [Int]
unpack_range (RangeT a b) = return [a .. b]
unpack_range (UnconstrT) = fail "attempt to list inifinite range"

-- | ArrayT of IntType generates Arrays of this type
instance (MonadElab m, Createable m x) => Createable m (ArrayT x) where
    type SR (ArrayT x) = Ptr (ArrayR (SR x))
    type VR (ArrayT x) = Ptr (ArrayR (VR x))

    alloc_signal n t f = do
        indexes <- unpack_range (arange t)
        pairs <- forM indexes (\i -> do
            let sn = n ++ (printf "[%d]" i)
            (_,r) <- alloc_signal sn (aconstr t) id
            return (i,r))
        f $ pairM (pure t) (allocM (ArrayR n (IntMap.fromList pairs)))

    alloc_variable n t f = do
        indexes <- unpack_range (arange t)
        pairs <- forM indexes (\i -> do
            let sn = n ++ (printf "[%d]" i)
            (_,r) <- alloc_variable sn (aconstr t) id
            return (i,r))
        f $ pairM (pure t) (allocM (ArrayR n (IntMap.fromList pairs)))

alloc_urange :: (MonadElab m) => m RangeT
alloc_urange = pure UnconstrT

alloc_range :: (MonadElab m) => m Int -> m Int -> m RangeT
alloc_range a b = RangeT <$> a <*> b

alloc_array_type :: (MonadElab m) => m RangeT -> t -> m (ArrayT t)
alloc_array_type mr t = ArrayT <$> (pure t) <*> mr

index :: (MonadPtr m) => m Int -> m (Array t a) -> m (t,a)
index mi mc = do
    (ta, ra) <- mc
    mb <- IntMap.lookup <$> mi <*> (csignals <$> (derefM ra))
    case mb of
        Nothing -> fail "index: out of range"
        (Just x) -> return (aconstr ta, x)

setidx :: (MonadPtr m) => m Int -> Assigner m (t,x) -> (Array t x) -> m (Array t x)
setidx mi f r = f (index mi (pure r)) >> return r

setall :: (MonadPtr m) => Assigner m (t,x) -> (Array t x) -> m (Array t x)
setall f a@(ArrayT te _,r) = do
    mapM_ (\(k,re) -> f (pure (te,re))) =<< (IntMap.toList <$> (csignals <$> derefM r))
    return a

instance (MonadPtr m) => Assignable (Elab m) (Array t x) (Array t x) where
    assign = undefined

instance (MonadPtr m) => Subtypeable m (ArrayT t) where
    type SM (ArrayT t) = RangeT
    alloc_subtype mr a = mr >>= \ r -> return $ a { arange = r } 

-- instance Constrained (ArrayT t, ArrayR x)

