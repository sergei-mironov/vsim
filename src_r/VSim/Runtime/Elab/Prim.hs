{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RankNTypes #-}

module VSim.Runtime.Elab.Prim where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans
import Control.Monad.Reader
import Control.Monad.State.Strict
import Data.IntMap as IntMap
import Data.Unique
import Data.Range
import Data.Set as Set
import Text.Printf
import System.Random

import VSim.Runtime.Time
import VSim.Runtime.Monad
import VSim.Runtime.Class
import VSim.Runtime.Ptr
import VSim.Runtime.Waveform
import VSim.Runtime.Elab.Class

instance Representable (PrimitiveT t) where
    type SR (PrimitiveT t) = Ptr (SigR t)
    type VR (PrimitiveT t) = Ptr (VarR t)
    type CR (PrimitiveT t) = t

{- Createable -}

typeval (PrimitiveT l _) = l

fixup_signal tgt@(Value n t r)
    | not (isNull r) = return tgt
    | otherwise = do
        u <- liftIO (hashUnique <$> newUnique)
        r' <- allocM $ SigR (wconst (typeval t)) Set.empty u
        return $ Value n t r'

fixup_variable tgt@(Value n t r)
    | not (isNull r) = return tgt
    | otherwise = do
        r' <- allocM $ VarR (typeval t)
        return $ Value n t r'

convert (Value n t r) = Value n t r

addmem sig = do
    get_mem >>= addToMem sig >>= put_mem
    return sig

alloc_nullptr n t = return (Value n t nullPtr)

alloc_defval n t = return (Value n t (typeval t))

instance (MonadMem m) => Createable m (PrimitiveT Int) (Ptr (SigR Int)) where
    alloc = alloc_nullptr
    fixup x = fixup_signal x >>= addmem

instance (MonadMem m) => Createable m (PrimitiveT t) (Ptr (VarR t)) where
    alloc = alloc_nullptr
    fixup = fixup_variable

instance (MonadPtr m) => Createable m (PrimitiveT t) t where
    alloc = alloc_defval
    fixup = return

{- Assignable -}

elab_sig_link src@(Value _ _ r') (Value n t _) = do
    return $ Value n t r'

elab_sig_clone vv tgt = do
    tgt'@(Value _ _ r') <- fixup_signal tgt
    v <- hug (val vv)
    p <- updateM (\s -> s { swave = (wconst v)}) r'
    return tgt'

elab_var_clone vv tgt = do
    tgt'@(Value _ _ r') <- fixup_variable tgt
    v <- Clone (val vv)
    p <- updateM (\var -> var{ vval = v} ) r'
    return tgt'

-- | Generate request for signal update in the process monad.
proc_sig_update vv tgt = do
    v <- hug (val vv)
    modify (\plan -> ((tgt,v):plan))
    return tgt

proc_var_update vv tgt@(Value n t r) = do
    v <- hug (val vv)
    updateM (\var -> var{ vval = v }) r
    ccheck tgt
    return tgt

const_var_update vv tgt@(Value n t r) = do
    v <- hug (val vv)
    return $ Value n t v

instance (MonadPtr m) => Assignable (Link m) (Signal Int) (Signal Int) where
        assign' = elab_sig_link
instance (MonadPtr m) => Assignable (Link m) Variable (Signal Int) where
        assign' = elab_sig_clone
instance (MonadPtr m) => Assignable (Link m) Int (Signal Int) where
        assign' = elab_sig_clone

instance (MonadPtr m) => Assignable (Clone (Elab m)) (Signal Int) (Signal Int) where
        assign' = elab_sig_clone
instance (MonadPtr m) => Assignable (Clone (Elab m)) Variable (Signal Int) where
        assign' = elab_sig_clone
instance (MonadPtr m) => Assignable (Clone (Elab m)) Constant (Signal Int) where
        assign' = elab_sig_clone
instance (MonadPtr m) => Assignable (Clone (Elab m)) Int (Signal Int) where
        assign' = elab_sig_clone

instance (MonadPtr m) => Assignable (Clone (Elab m)) (Signal Int) Variable where
        assign' = elab_var_clone
instance (MonadPtr m) => Assignable (Clone (Elab m)) Variable Variable where
        assign' = elab_var_clone
instance (MonadPtr m) => Assignable (Clone (Elab m)) Constant Variable where
        assign' = elab_var_clone
instance (MonadPtr m) => Assignable (Clone (Elab m)) Int Variable where
        assign' = elab_var_clone

instance (MonadPtr m, Valueable m v) => Assignable (Assign m) v (Signal Int) where
        assign' = proc_sig_update
instance (MonadPtr m, Valueable m v) => Assignable (Assign m) v Variable where
        assign' = proc_var_update


instance (MonadPtr m, Valueable m v) => Assignable (Clone m) v Constant where
        assign' = const_var_update

{- Type stuff -}

instance Subtypeable (PrimitiveT Int) where
    type SM (PrimitiveT Int) = RangeT
    build_subtype (RangeT u l) p = (PrimitiveT u l)
    build_subtype (UnconstrT) p = PrimitiveT minBound maxBound
    build_subtype (NullRangeT) _ = error "build_subtype: don't know what to do with Null ranges"

    valid_subtype_of (PrimitiveT b1 e1) (PrimitiveT b2 e2) =
        ((RangeT b1 e1) `inner_of` (RangeT b2 e2))

{- Valueable -}

instance (Monad m) => Valueable m Constant where
    val v = return (vr v)

instance (MonadPtr m) => Valueable m Variable where
    val v = liftPtr $ vval <$> derefM (vr v)

instance Valueable (VProc l) (Signal Int) where
    val (Value n t r) = now >>= \t -> liftPtr $ valueAt1 t <$> (swave <$> derefM r)

instance (MonadPtr m) => Valueable (Elab m) (Signal Int) where
    -- FIXME: I am not sure that it is ok to ask minBound in Elab monad
    val (Value n t r) = liftPtr $ valueAt minBound <$> (swave <$> derefM r)

{- Imageable -}

instance (MonadProc m) => Imageable m (Signal Int) (PrimitiveT Int) where
    t_image mr _ = show <$> (valueAt1 <$> now <*> (swave <$> (derefM =<< (vr <$> mr))))

instance (MonadProc m) => Imageable m Variable (PrimitiveT Int) where
    t_image mr _ = show <$> (vval <$> (derefM =<< (vr <$> mr)))

instance (MonadProc m) => Imageable m Constant (PrimitiveT Int) where
    t_image mr _ = (show . vr) <$> mr

instance (Show t, MonadProc m) => Imageable m t (PrimitiveT t) where
    t_image mr _ = show <$> mr


