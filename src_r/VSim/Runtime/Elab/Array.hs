{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}

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
    alloc n t = allocM (Array2.empty n)

alloc_urange :: (MonadElab m) => m RangeT
alloc_urange = pure UnconstrT

alloc_range :: (MonadElab m) => m Int -> m Int -> m RangeT
alloc_range a b = RangeT <$> a <*> b

alloc_array_type :: (MonadElab m) => m RangeT -> t -> m (ArrayT t)
alloc_array_type mr t = ArrayT <$> (pure t) <*> mr

lookupUpd idx def m = (fromMaybe def r, m') where 
    (r,m') = IntMap.insertLookupWithKey (\_ a _ -> a) idx def m

index :: (MonadPtr m, Createable m t a)
    => m Int -> m (Array t a) -> m (t,a)
index mi mc = do
    (ArrayT te rg, r) <- mc
    idx <- mi
    a2 <- derefM r
    when (not (inrage idx rg)) $ do
        fail "index: array index out of range"
    (e,a2') <- readArrayDef a2 idx (\n -> alloc n te)
    writeM r a2'
    return (te, e)

setidx :: (MonadPtr m, Createable m t a)
    => m Int -> Assigner m (t,a) -> (Array t a) -> m (Array t a)
setidx mi f r = f (index mi (pure r)) >> return r

setall :: (MonadPtr m, Createable m t a)
    => Assigner m (t,a) -> (Array t a) -> m (Array t a)
setall f a@(ArrayT te (RangeT l u),r) = do
    a2 <- derefM r
    let iterate [] a2 = return a2
        iterate (i:is) a2 = do
            (_,a2') <- readArrayDef a2 i (\n -> alloc n te)
            iterate is a2'
    a2' <- iterate [l..u] a2
    writeM r a2'
    return a

setall f a@(ArrayT te (UnconstrT), r) = do
    fail "setall: calling on unconstrained array"

instance (MonadPtr m) => Assignable (Elab m) (Array t x) (Array t x) where
    assign = error "FIXME: define array assignments"

instance (Subtypeable t) => Subtypeable (ArrayT t) where
    type SM (ArrayT t) = RangeT
    build_subtype r a = a { arange = r } 
    valid_subtype_of (ArrayT t1 r1) (ArrayT t2 r2) =
        (t1 `valid_subtype_of` t2) && (r1 `inner_range` r2)

