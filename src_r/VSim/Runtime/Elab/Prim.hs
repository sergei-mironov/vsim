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

alloc_prim n t method f = f method (Value t n nullPtr)

fixup_signal tgt@(Value t n r)
    | not (isNull r) = return tgt
    | otherwise = do
        u <- liftIO (hashUnique <$> newUnique)
        p <- allocM $ SigR (wconst (typeval t)) [] u 
        let tgt' = tgt{vr = p}
        modify_mem (\m -> m{ msignals = (tgt':msignals m)})
        return tgt'

fixup_variable tgt@(Value t n r)
    | not (isNull r) = return tgt
    | otherwise = do
        p <- allocM $ VarR (typeval t)
        let tgt' = tgt{vr = p}
        return tgt'

instance (MonadPtr m) => Createable (Elab m) PrimitiveT method Signal where
    alloc n t m f = alloc_prim n t m f >>= fixup_signal

instance (MonadPtr m) => Createable (Elab m) PrimitiveT method Variable where
    alloc n t m f = alloc_prim n t m f >>= fixup_variable

{- Assignable -}

elab_sig_link (Value _ n r') _ tgt = do
    check_null tgt
    let tgt' =  tgt{ vr = r' }
    modify_mem (\m -> m{ msignals = (tgt':msignals m)})
    return tgt'

elab_sig_update vv _ tgt_ = do
    tgt <- fixup_signal tgt_
    v <- val vv
    p <- updateM (\s -> s { swave = (wconst v)}) (vr tgt)
    return tgt

elab_var_update vv _ tgt_ = do
    tgt <- fixup_variable tgt_
    v <- val vv
    p <- updateM (\var -> var{ vval = v} ) (vr tgt)
    return tgt

-- | Generate request for signal's update for the process's monad.
proc_sig_update vv _ (plan,tgt) = do
    v <- val vv
    return ((tgt,v):plan, tgt)

proc_var_update vv _ tgt@(var) = do
    v <- val vv
    updateM (\var -> var{ vval = v }) (vr var)
    ccheck var
    return tgt

instance (MonadPtr m) => Assignable (Elab m) Signal Link Signal where
        assign = elab_sig_link
instance (MonadPtr m) => Assignable (Elab m) Variable Link Signal where
        assign = elab_sig_update
instance (MonadPtr m) => Assignable (Elab m) Int Link Signal where
        assign = elab_sig_update

instance (MonadPtr m) => Assignable (Elab m) Signal Clone Signal where
        assign = elab_sig_update
instance (MonadPtr m) => Assignable (Elab m) Variable Clone Signal where
        assign = elab_sig_update
instance (MonadPtr m) => Assignable (Elab m) Int Clone Signal where
        assign = elab_sig_update

instance (MonadPtr m) => Assignable (Elab m) Signal Clone Variable where
        assign = elab_var_update
instance (MonadPtr m) => Assignable (Elab m) Variable Clone Variable where
        assign = elab_var_update
instance (MonadPtr m) => Assignable (Elab m) Int Clone Variable where
        assign = elab_var_update

instance (Valueable (VProc l) v) => Assignable (VProc l) v Clone (Plan,Signal) where
        assign = proc_sig_update
instance (Valueable (VProc l) v) => Assignable (VProc l) v Clone Variable where
        assign = proc_var_update

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


