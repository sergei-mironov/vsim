{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}

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

instance Primitive Int where
    type RANGE Int = RangeT
    make_range l u = RangeT l u

instance PrimitiveRange RangeT where
    type PRIM RangeT = PrimitiveT
    make_ranged_type (RangeT l u) = PrimitiveT l u
    make_ranged_type (UnconstrT) = PrimitiveT minBound maxBound

instance Representable PrimitiveT where
    type SR PrimitiveT = Ptr SigR
    type VR PrimitiveT = Ptr VarR

instance (MonadMem m) => Createable m PrimitiveT (Ptr SigR) where
    alloc n (PrimitiveT l r) = do
        u <- liftIO newUnique
        r <- allocM (SigR n (wconst l) 0 [] (hashUnique u))
        modify_mem $ \(Memory rs ps) -> Memory (r:rs) ps
        return r

instance (MonadPtr m) => Createable m PrimitiveT (Ptr VarR) where
    alloc n (PrimitiveT l r) = allocM (VarR n l)

-- Type stuff

instance Subtypeable PrimitiveT where
    type SM PrimitiveT = RangeT
    build_subtype (RangeT u l) p = (PrimitiveT u l)
    build_subtype (UnconstrT) p = PrimitiveT minBound maxBound

    valid_subtype_of (PrimitiveT b1 e1) (PrimitiveT b2 e2) =
        ((RangeT b1 e1) `inner_range` (RangeT b2 e2))

-- Constrained
-- see VSim.Runtime.Monad

-- Valueable

instance (MonadPtr m) => Valueable m Variable where
    val (_,r) = vval <$> derefM r

instance Valueable (VProc l) Signal where
    val (_,r) = valueAt1 <$> now <*> (swave <$> derefM r)

instance (MonadPtr m) => Valueable (Elab m) Signal where
    -- FIXME: I am not sure that it is ok to ask minBound in Elab monad
    val (_,r) = valueAt <$> (pure minBound) <*> (swave <$> derefM r)

-- Imageable

instance (MonadProc m) => Imageable m Signal PrimitiveT where
    t_image mr _ = show <$> (valueAt1 <$> now <*> (swave <$> (derefM =<< (snd <$> mr))))

instance (MonadProc m) => Imageable m Variable PrimitiveT where
    t_image mr _ = show <$> (vval <$> (derefM =<< (snd <$> mr)))

instance (MonadProc m) => Imageable m Int PrimitiveT where
    t_image mr _ = show <$> mr

-- Assignable

-- | Update the signal inplace. For elaboration only.
basic_sig_update mv mr = do
    v <- (mv >>= val)
    x <- mr
    updateM (\s -> s{ swave = wconst v }) (snd x)
    ccheck x
    return []

-- | Update the variable inplace. For elaboration only.
basic_var_update mv mr = do
    v <- (mv >>= val)
    x <- mr
    updateM (\var -> var{ vval = v }) (snd x)
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

