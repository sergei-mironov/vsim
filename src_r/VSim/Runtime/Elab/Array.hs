{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module VSim.Runtime.Elab.Array where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans
import Text.Printf
import Data.Maybe
import Data.IntMap as IntMap
import Data.Array2 as Array2
import Data.Range as Range

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
    type SR (ArrayT t) = ArrayR (SR t)
    type VR (ArrayT t) = ArrayR (VR t)
    type FR (ArrayT t) = ArrayR (FR t)

replace_unconstr UnconstrT x = x
replace_unconstr (RangeT l u) _ = RangeT l u
replace_unconstr NullRangeT _ = NullRangeT

item_name :: String -> Int -> String
item_name n i = printf "%s[%d]" n i

{- Indexable -}

instance (MonadPtr m) => Indexable m (Array t x) (Value t x) where
    index' i (Value (ArrayT t UnconstrT) n _) = do
            pfail "index: not constrained: array %s" n
    index' i (Value (ArrayT et rg) n a2) = do
        let en = item_name n i
        er <- unMaybeM (Array2.index i a2) (
            pfail "index: failure: item %s" en)
        return (Value et en er)

{- Createable -}

fixup_array n (Value_u t a2) = do
    let process (i,Nothing) = do
            item <- (alloc (aconstr t) >>= fixup (item_name n i))
            return (i, vr item)
        process (i,Just x) = do
            item <- fixup (item_name n i) (Value_u (aconstr t) x)
            return (i,vr item)
    l <- forM (Array2.toList (arange t) a2) process
    return (Value t n (Array2.fromList l))

instance (Createable m t x)
    => Createable m (ArrayT t) (ArrayR x) where
        alloc t = return (Value_u t Array2.empty)
        fixup = fixup_array

{- Accessable -}

elab_access i f (Value_u t a2) = do
    item <- alloc_agg (aconstr t) f
    a2' <- return (Array2.update i (ur item) a2)
    return (Value_u t a2')

array_access_all' f arr UnconstrT = do
    fail "elab_access_all: can't loop unconstrained array"
array_access_all' f arr rg = do
    loopM arr (Range.toList rg) $ \arr i -> do
        access' i f arr

instance (Createable (Clone m) t x)
    => Accessable (Clone m) (Array_u t x) (Value_u t x) where
        access' = elab_access
        access_all f arr = array_access_all' f arr (arange $ ut arr)

instance (Createable (Link m) t x)
    => Accessable (Link m) (Array_u t x) (Value_u t x) where
        access' = elab_access
        access_all f arr = array_access_all' f arr (arange $ ut arr)

proc_access i f val@(Value (ArrayT et _) n a2) = do
    item <- unMaybeM (Array2.index i a2) (
        pfail2 "proc_access: index not found: array %s index %d" n i)
    f (Value et (item_name n i) item)
    return val

instance Accessable (Assign l) (Array t x) (Value t x) where
    access' = proc_access
    access_all f arr = array_access_all' f arr (arange $ vt arr)

{- Assignable -}

elab_assign rh@(Value t' n' a2') lh@(Value_u t a2) = do
    let is = (Range.toList $ arange t')
    a2' <- loopM a2 is (\a2 i -> do
        erh <- index' i rh
        elh <- alloc_agg (aconstr t) (assign' erh)
        return (Array2.update i (ur elh) a2))
    return (Value_u t a2')

instance (
    Createable (Clone m) t x,
    Assignable (Clone m) (Value t x) (Value_u t x),
    Indexable (Clone m) (Array t x) (Value t x))
    => Assignable (Clone m) (Array t x) (Array_u t x) where
        assign' = elab_assign

instance (
    Createable (Link m) t x,
    Assignable (Link m) (Value t x) (Value_u t x),
    Indexable (Link m) (Array t x) (Value t x))
    => Assignable (Link m) (Array t x) (Array_u t x) where
        assign' = elab_assign

-- FIXME: inefficient
proc_assign rh lh@(Value (ArrayT _ rg) _ _) = do
    forM_ (Range.toList rg) (\i -> do
        erh <- index' i rh
        elh <- index' i lh
        assign' erh elh)
    return lh

instance (Assignable (Assign l) (Value t e) (Value t e),
    Indexable (Assign l) (Array t e) (Value t e))
    => Assignable (Assign l) (Array t e) (Array t e) where
        assign' = proc_assign

