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

import VSim.Runtime.Monad
import VSim.Runtime.Class
import VSim.Runtime.Ptr
import VSim.Runtime.Elab.Prim

unpack_range :: (Monad m) => RangeT -> m [Int]
unpack_range (RangeT a b) = return [a .. b]
unpack_range (UnconstrT) = fail "attempt to list inifinite range"

-- | ArrayT of IntType generates Arrays of this type
instance (Representable t) => Representable (ArrayT t) where
    type SR (ArrayT t) = Ptr (ArrayR (SR t))
    type VR (ArrayT t) = Ptr (ArrayR (VR t))

instance (MonadPtr m, Createable m t r) => Createable m (ArrayT t) (Ptr (ArrayR r)) where
    alloc n (ArrayT t UnconstrT) = allocM (Array2.empty n)
    alloc n (ArrayT t (RangeT l u)) = allocDef n [l..u] (\n -> alloc n t) >>= allocM
    fixup (ArrayT t UnconstrT, r) = do
        a2 <- derefM r
        let (l,u) = scanRange a2
        let iterate [] a2 = return a2
            iterate (i:is) a2 = do
                a2' <- allocHole a2 i (\n -> alloc n t)
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

lookupUpd idx def m = (fromMaybe def r, m') where 
    (r,m') = IntMap.insertLookupWithKey (\_ a _ -> a) idx def m

index :: (MonadPtr m, Arrayable m a el) => m Int -> m a -> m el
index mi ma = mi >>= \i -> ma >>= \a -> idx i a

setidx :: (MonadPtr m, Arrayable m a e) => m Int -> Assigner m e -> a -> m a
setidx mi f r = f (index mi (pure r)) >> return r

setall :: (MonadPtr m, Arrayable m a el) => Assigner m el -> a -> m a
setall f a = iter f a >> return a

instance (MonadPtr m) => Assignable (Elab m) (Array t x) (Array t x) where
    assign = error "FIXME: define array assignments"

instance (Subtypeable t) => Subtypeable (ArrayT t) where
    type SM (ArrayT t) = RangeT
    build_subtype r a = a { arange = r } 
    valid_subtype_of (ArrayT t1 r1) (ArrayT t2 r2) =
        (t1 `valid_subtype_of` t2) && (r1 `inner_range` r2)

idx_elab i (ArrayT te rg, r) = do
    a2 <- derefM r
    when (not (inrage i rg)) $ do
        fail "index: array index out of range"
    (e,a2') <- readArrayDef a2 i (\n -> alloc n te)
    writeM r a2'
    return (te, e)

iter_elab f (ArrayT te UnconstrT, _) = do
    fail "iterate in elab without ranges"
iter_elab f (ArrayT te (RangeT l u), r) = do
    let iterate [] a2 = return a2
        iterate (i:is) a2 = do
            (_,a2') <- readArrayDef a2 i (\n -> alloc n te)
            iterate is a2'
    derefM r >>= iterate [l..u] >>= writeM r

idx_proc i (ArrayT te rg, r) = do
    a2 <- derefM r
    when (not (inrage i rg)) $ do
        fail "index: array index out of range"
    e <- readArray a2 i
    return (te, e)

iter_proc f (ArrayT te UnconstrT, _) = do
    fail "iterate in vproc without ranges"
iter_proc f (ArrayT te (RangeT l u), r) = do
    a2 <- derefM r
    forM_ [l..u] $ \i -> do
        e <- readArray a2 i
        f $ pure (te,e)

class (Monad m) => Arrayable m a el | a -> el where
    idx :: Int -> a -> m el
    iter :: Assigner m el -> a -> m ()

instance (MonadPtr m, Createable (Elab m) t a) => Arrayable (Elab m) (Array t a) (t,a) where
    idx = idx_elab
    iter = iter_elab

instance Arrayable (VAssign l) (Array t a) (t,a) where
    idx = idx_proc
    iter = iter_proc

instance Arrayable (VProc l) (Array t a) (t,a) where
    idx = idx_proc
    iter = iter_proc

