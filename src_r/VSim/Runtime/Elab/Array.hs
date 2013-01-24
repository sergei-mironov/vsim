{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
-- {-# LANGUAGE FunctionalDependencies #-}

module VSim.Runtime.Elab.Array where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans
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

alloc_array_type :: (MonadElab m) => m RangeT -> t -> m (ArrayT t)
alloc_array_type mr t = ArrayT <$> (pure t) <*> mr

-- | ArrayT of IntType generates Arrays of this type
instance (Representable t) => Representable (ArrayT t) where
    type SR (ArrayT t) = Ptr (ArrayR (SR t))
    type VR (ArrayT t) = Ptr (ArrayR (VR t))
    type FR (ArrayT t) = ArrayR (FR t)

-- Fill unallocated array items with their default values
fixup_array (Value (ArrayT t rg) n r) = do
    lu <- scanRange <$> derefM r
    let rg'@(RangeT l u) = rg`subst_with` lu
    when (not (rg' `inner_of` rg)) $ fail "range failure"
    withM r $ \a2 -> do
        let flipFoldM a b f = foldM f a b
        flipFoldM a2 [l..u] $ \a i -> do
            allocIfNull i (vr <$> alloc0 [] t) a
    return (Value (ArrayT t rg') n r)

alloc_empty_array n t@(ArrayT te rg) = do
    Value t n `liftM` allocM Array2.empty

alloc_clone_array n t src = do
    val <- alloc_empty_array n t
    lift $ assign (pure src) (pure val)
    fixup_array val

instance (Createable0 m (Value t x))
    => Createable0 m (Array t x) where
        alloc0 n t = alloc_empty_array n t >>= fixup_array

instance (Createable0 (Clone (Elab m)) (Value t x), MonadPtr m)
    => Createable (Clone (Elab m)) (Array t x) (Array t x) where
        alloc n t src = alloc_clone_array n t src

instance (Createable0 (Link (Elab m)) (Value t x), MonadPtr m)
    => Createable (Link (Elab m)) (Array t x) (Array t x) where
        alloc n t src = return (Value t n (vr src))

instance (Createable0 m (Value t x))
    => Createable m (Array t x) () where
        alloc n t () = alloc0 n t

instance (Createable0 m (Value t x))
    => CreateableA m (Array t x) where
        allocA n t agg = do
            val <- alloc0 n t 
            forM_ agg (\f -> f val)
            fixup_array val

index mi mv = mi >>= \i -> mv >>= \v -> index' i v

index' i (Value (ArrayT t UnconstrT) n _) =
    pfail "not constraines: array %s" n
index' i (Value (ArrayT et rg) n r) = do
    let en = printf "%s[%d]" n i
    er <- maybeDerefM (fail "index failure: item %s" en) (readArray i) r
    return (Value et en er)

access_elab i x (Value (ArrayT te rg) n r) = do
    Value _ _ e <- alloc "<fixme>" te x
    maybeUpdateM (fail "already alocated") (Array2.allocItem i e) r
 
instance (Createable (Clone m) (Value t e) x) => Accessable (Clone m) (Array t e) x () where
    access = access_elab

instance (Createable (Link m) (Value t e) x) => Accessable (Link m) (Array t e) x () where
    access = access_elab

access_proc i x (Value (ArrayT et rg) n r) = do
    let en = printf "%s[%d]" n i
    er <- maybeDerefM (fail "access failure: item %s" en) (readArray i) r
    ret <- lift $ assign (pure x) (pure $ Value et en er)
    return ret
    
instance (Assignable (VProc l) (Value t e) x)
    => Accessable (Access (VProc l)) (Array t e) x Plan where
        access = access_proc

setidx :: (Accessable (m m1) a x r, Monad m1, Monad (m m1), MonadTrans m)
    => m1 Int -> m1 x -> a -> (m m1) r
setidx mi mx a = do
    i <- lift mi
    x <- lift mx
    access i x a

instance Assignable (VProc l) (Array t x) (Array t x) where
    assign mv mr = error "undefined: array assignments"

instance (MonadPtr m) => Assignable (Elab m) (Array t x) (Array t x) where
    assign mv mr = error "undefined: array assignments"

{-
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

-}


