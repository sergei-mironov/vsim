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

typeval (PrimitiveT l _) = l

alloc_signal_def n t = do
    h <- hashUnique <$> liftIO newUnique
    w <- pure $ wconst (typeval t)
    r <- allocM (SigR w [] h)
    return (Value t n r)


-- Clone a signal
alloc_signal_clone n t src = do
    val <- alloc_signal_def n t
    lift $ assign (pure src) (pure val)
    return val

-- Map a signal
alloc_signal_link n t src = do
    return (Value t n (vr src))

instance (MonadElab m) => Createable0 m Signal where
    alloc0 = alloc_signal_def
instance (MonadPtr m) => Createable (Clone (Elab m)) Signal Signal where
    alloc = alloc_signal_clone
instance (MonadPtr m) => Createable (Link (Elab m)) Signal Signal where
    alloc = alloc_signal_link
instance (MonadPtr m) => Createable (Clone (Elab m)) Signal Variable where
    alloc = alloc_signal_clone
instance (MonadPtr m) => Createable (Clone (Elab m)) Signal Int where
    alloc = alloc_signal_clone
instance (MonadPtr m) => Createable (Clone (Elab m)) Signal () where
    alloc n t () = alloc_signal_def n t
instance (MonadPtr m) => CreateableA (Clone (Elab m)) Signal where
    allocA n t agg = do
        val <- alloc n t ()
        forM_ agg $ \f -> do f val
        return val

-- Clone a variable
alloc_var_def n t = do
    r <- allocM (VarR (typeval t))
    return (Value t n r)

instance (MonadPtr m) => Createable0 (Clone (Elab m)) Variable where
    alloc0 = alloc_var_def

alloc_var_clone n t src = do
    val <- alloc_var_def n t
    lift $ assign (pure src) (pure val)
    return val

instance (MonadPtr m) => Createable (Clone (Elab m)) Variable Variable where
    alloc = alloc_var_clone
instance (MonadPtr m) => Createable (Clone (Elab m)) Variable Signal where
    alloc = alloc_var_clone
instance (MonadPtr m) => Createable (Clone (Elab m)) Variable Int where
    alloc = alloc_var_clone
instance (MonadPtr m) => Createable (Clone (Elab m)) Variable () where
    alloc n t () = alloc_var_def n t

-- Type stuff

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

{- Assignable -}

-- | Update the signal inplace. For elaboration only.
basic_sig_update mv mr = do
    v <- (mv >>= val)
    x <- mr
    updateM (\s -> s{ swave = wconst v }) (vr x)
    ccheck x
    return []

-- | Update the variable inplace. For elaboration only.
basic_var_update mv mr = do
    v <- (mv >>= val)
    x <- mr
    updateM (\var -> var{ vval = v }) (vr x)
    ccheck x
    return []

-- | Generate request for signal's update for the process's monad.
proc_sig_update mv mr = do
    r <- mr
    v <- (val =<< mv)
    return [(r,v)]

-- Elaboration
instance (MonadPtr m, Valueable (Elab m) v) => Assignable (Elab m) Signal v where
    assign = basic_sig_update
instance (MonadPtr m, Valueable (Elab m) v) => Assignable (Elab m) Variable v where
    assign = basic_var_update

-- Process
instance (Valueable (VProc l) v) => Assignable (VProc l) Signal v where
    assign = proc_sig_update
instance (Valueable (VProc l) v) => Assignable (VProc l) Variable v where
    assign = basic_var_update


