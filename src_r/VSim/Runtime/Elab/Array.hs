{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}

module VSim.Runtime.Elab.Array where

import Control.Applicative
import Control.Monad
import Text.Printf
import Data.Maybe
import Data.IntMap as IntMap
import Data.Array2 as Array2

import VSim.Runtime.Waveform
import VSim.Runtime.Time
import VSim.Runtime.Monad
import VSim.Runtime.Class
import VSim.Runtime.Ptr
import VSim.Runtime.Elab.Prim
import VSim.Runtime.Elab.Class

unpack_range :: (Monad m) => RangeT -> m [Int]
unpack_range (RangeT a b) = return [a .. b]
unpack_range (UnconstrT) = fail "attempt to list inifinite range"

-- | ArrayT of IntType generates Arrays of this type
instance (Representable t) => Representable (ArrayT t) where
    type SR (ArrayT t) = Ptr (ArrayR (SR t))
    type VR (ArrayT t) = Ptr (ArrayR (VR t))
    type FR (ArrayT t) = ArrayR (FR t)

instance (MonadPtr m, Createable m t r) => Createable m (ArrayT t) (Ptr (ArrayR r)) where
    alloc n (ArrayT t UnconstrT) = allocM (Array2.empty n)
    alloc n (ArrayT t (RangeT l u)) = allocDef n [l..u] (\n -> alloc n t) >>= allocM
    fixup (ArrayT t UnconstrT, r) = do
        a2 <- derefM r
        let (l,u) = scanRange a2
        let iterate [] a2 = return a2
            iterate (i:is) a2 = do
                a2' <- allocIfNull a2 i (\n -> alloc n t)
                iterate is a2'
        a2' <- iterate [l..u] a2
        writeM r a2'
        return (ArrayT t (RangeT l u), r)
    fixup x = return x

alloc_urange :: (MonadElab m) => m RangeT
alloc_urange = pure UnconstrT

alloc_range :: (MonadElab m) => m Int -> m Int -> m RangeT
alloc_range a b = RangeT <$> a <*> b

alloc_array_type :: (MonadElab m) => m RangeT -> t -> m (ArrayT t)
alloc_array_type mr t = ArrayT <$> (pure t) <*> mr

index :: (MonadPtr m, Arrayable m a el) => m Int -> m a -> m el
index mi ma = mi >>= \i -> ma >>= \a -> safeIdx i a

setidx :: (MonadPtr m, Arrayable m (Array t e) (t,e))
    => m Int -> Assigner m (t,e) -> Array t e -> m Plan
setidx mi f r = f (index mi (pure r))

setall :: (MonadPtr m, Arrayable m (Array t e) (t,e))
    => Assigner m (t,e) -> Array t e -> m Plan
setall f a = iter f a

instance (MonadPtr m) => Assignable (Elab m) (Array t x) (Array t x) where
    assign = error "FIXME: define array assignments"

instance (Subtypeable t) => Subtypeable (ArrayT t) where
    type SM (ArrayT t) = RangeT
    build_subtype r a = a { arange = r } 
    valid_subtype_of (ArrayT t1 r1) (ArrayT t2 r2) =
        (t1 `valid_subtype_of` t2) && (r1 `inner_range` r2)

iter :: (MonadPtr m, Arrayable m (Array t e) (t,e))
    => Assigner m (t,e) -> Array t e -> m Plan
iter f a@(ArrayT _ UnconstrT, _) = do
    fail "iterate in without ranges"
iter f a@(ArrayT te (RangeT l u), r) = do
    concat <$> forM [l..u] (\i -> f (unsafeIdx i a))

class (Monad m) => Arrayable m a el | a -> el where
    safeIdx :: Int -> a -> m el
    unsafeIdx :: Int -> a -> m el

instance (MonadPtr m, Createable (Elab m) t a) =>
         Arrayable (Elab m) (Array t a) (t,a) where

    safeIdx i a@(ArrayT te rg@(UnconstrT), r) = do
        unsafeIdx i a
    safeIdx i a@(ArrayT te rg@(RangeT _ _), r) = do
        when (not (inrage i rg)) $ do
            fail "index: array index out of range"
        unsafeIdx i a

    unsafeIdx i a@(ArrayT te _, r) = do
        a2 <- derefM r
        (e,a2') <- readArrayDef a2 i (\n -> alloc n te)
        writeM r a2'
        return (te, e)

instance Arrayable (VProc l) (Array t a) (t,a) where

    safeIdx i a@(ArrayT te UnconstrT, r) = do
        fail "idx_proc: can't deindex the unconstrained array"
    safeIdx i a@(ArrayT te rg@(RangeT _ _), r) = do
        when (not (inrage i rg)) $ do
            fail "index: array index out of range"
        unsafeIdx i a

    unsafeIdx i (ArrayT te UnconstrT, r) = do
        fail "idx_proc: can't deindex the unconstrained array"
    unsafeIdx i (ArrayT te rg@(RangeT _ _), r) = do
        a2 <- derefM r
        e <- readArray a2 i
        return (te, e)


-- FIXME: define the undefined
instance (Valueable (VProc l) x)
    => Assignable (VProc l) (Array t x) (Array t x) where
    assign mv mr = undefined

-- FIXME: define the undefined
instance (Valueable (VProc l) x)
    => Assignable (VProc l) (Record t x) (Record t x) where
    assign mv mr = undefined

