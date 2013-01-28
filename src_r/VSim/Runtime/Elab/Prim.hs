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
import Control.Monad.State
import Data.IntMap as IntMap
import Data.Unique
import Data.Range
import Text.Printf
import System.Random

import VSim.Runtime.Time
import VSim.Runtime.Monad
import VSim.Runtime.Class
import VSim.Runtime.Ptr
import VSim.Runtime.Waveform
import VSim.Runtime.Elab.Class

instance Representable PrimitiveT where
    type SR PrimitiveT = Ptr SigR
    type VR PrimitiveT = Ptr VarR
    type FR PrimitiveT = Int

{- Createable -}

check_null x = when_not_null (vr x) (fail "check_null failed")

check_not_null x = when_null (vr x) (fail "check_not_null failed")

typeval (PrimitiveT l _) = l

alloc_prim n t f = f (Value t n nullPtr)

fixup_signal tgt@(Value t n r)
    | not (isNull r) = return tgt
    | otherwise = do
        u <- liftIO (hashUnique <$> newUnique)
        p <- allocM $ SigR (wconst (typeval t)) [] u
        return tgt{vr = p}

fixup_variable tgt@(Value t n r)
    | not (isNull r) = return tgt
    | otherwise = do
        p <- allocM $ VarR (typeval t)
        return tgt{vr = p}

elab_alloc_signal n t f = alloc_prim n t f >>= fixup_signal >>= addmem where
    addmem sig = modify_mem (\m -> m{ msignals = (sig:msignals m)}) >> return sig

alloc_var n t f = alloc_prim n t f >>= fixup_variable

instance (MonadPtr m) => Createable (Link m) PrimitiveT (Ptr SigR) where
    alloc = elab_alloc_signal
instance (MonadPtr m) => Createable (Clone m) PrimitiveT (Ptr SigR) where
    alloc = elab_alloc_signal
instance (MonadPtr m) => Createable (Clone m) PrimitiveT (Ptr VarR) where
    alloc = alloc_var

{- Assignable -}

elab_sig_link (Value _ n r') tgt = do
    check_null tgt
    return tgt{ vr = r' }

elab_sig_clone vv tgt_ = do
    tgt <- fixup_signal tgt_
    v <- hug (val vv)
    p <- updateM (\s -> s { swave = (wconst v)}) (vr tgt)
    return tgt

elab_var_clone vv tgt_ = do
    tgt <- fixup_variable tgt_
    v <- Clone (val vv)
    p <- updateM (\var -> var{ vval = v} ) (vr tgt)
    return tgt

-- | Generate request for signal update in the process monad.
proc_sig_update vv (plan,tgt) = do
    v <- Assign (val vv)
    return ((tgt,v):plan, tgt)

proc_var_update vv tgt@(var) = do
    v <- Assign (val vv)
    updateM (\var -> var{ vval = v }) (vr var)
    ccheck var
    return tgt

instance (MonadPtr m) => Assignable (Link m) Signal Signal where
        assign' = elab_sig_link
instance (MonadPtr m) => Assignable (Link m) Variable Signal where
        assign' = elab_sig_clone
instance (MonadPtr m) => Assignable (Link m) Int Signal where
        assign' = elab_sig_clone

instance (MonadPtr m) => Assignable (Clone m) Signal Signal where
        assign' = elab_sig_clone
instance (MonadPtr m) => Assignable (Clone m) Variable Signal where
        assign' = elab_sig_clone
instance (MonadPtr m) => Assignable (Clone m) Int Signal where
        assign' = elab_sig_clone

instance (MonadPtr m) => Assignable (Clone m) Signal Variable where
        assign' = elab_var_clone
instance (MonadPtr m) => Assignable (Clone m) Variable Variable where
        assign' = elab_var_clone
instance (MonadPtr m) => Assignable (Clone m) Int Variable where
        assign' = elab_var_clone

instance (Valueable (VProc l) v) => Assignable (Assign l) v (Plan,Signal) where
        assign' = proc_sig_update
instance (Valueable (VProc l) v) => Assignable (Assign l) v Variable where
        assign' = proc_var_update

{- Type stuff -}

instance Subtypeable PrimitiveT where
    type SM PrimitiveT = RangeT
    build_subtype (RangeT u l) p = (PrimitiveT u l)
    build_subtype (UnconstrT) p = PrimitiveT minBound maxBound

    valid_subtype_of (PrimitiveT b1 e1) (PrimitiveT b2 e2) =
        ((RangeT b1 e1) `inner_of` (RangeT b2 e2))

{- Valueable -}

instance (MonadPtr m) => Valueable m Variable where
    val v = vval <$> derefM (vr v)

instance Valueable (VProc l) Signal where
    val v = valueAt1 <$> now <*> (swave <$> derefM (vr v))

instance (MonadPtr m) => Valueable (Elab m) Signal where
    -- FIXME: I am not sure that it is ok to ask minBound in Elab monad
    val v = valueAt <$> (pure minBound) <*> (swave <$> derefM (vr v))

-- Imageable

instance (MonadProc m) => Imageable m Signal PrimitiveT where
    t_image mr _ = show <$> (valueAt1 <$> now <*> (swave <$> (derefM =<< (vr <$> mr))))

instance (MonadProc m) => Imageable m Variable PrimitiveT where
    t_image mr _ = show <$> (vval <$> (derefM =<< (vr <$> mr)))

instance (MonadProc m) => Imageable m Int PrimitiveT where
    t_image mr _ = show <$> mr


