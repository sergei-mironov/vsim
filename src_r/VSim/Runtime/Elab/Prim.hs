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
import Text.Printf
import System.Random

import VSim.Runtime.Monad
import VSim.Runtime.Class
import VSim.Runtime.Ptr
import VSim.Runtime.Waveform

instance Representable PrimitiveT where
    type SR PrimitiveT = Ptr SigR
    type VR PrimitiveT = Ptr VarR

instance (MonadMem m) => Createable m PrimitiveT (Ptr SigR) where
    alloc n (PrimitiveT l r) = do
        r <- allocM (SigR n (wconst l) 0 [])
        modify_mem $ \(Memory rs ps) -> Memory (r:rs) ps
        return r

instance (MonadPtr m) => Createable m PrimitiveT (Ptr VarR) where
    alloc n (PrimitiveT l r) = allocM (VarR n l)

rnd' :: (MonadIO m) => PrimitiveT -> m Int
rnd' c = liftIO $ randomRIO (lower c, upper c)

alloc_ranged_type :: (MonadElab m) => m Int -> m Int -> m PrimitiveT
alloc_ranged_type ma mb = ranged <$> ma <*> mb

alloc_unranged_type :: (MonadElab m) => m PrimitiveT
alloc_unranged_type = return unranged


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

instance Valueable VAssign Signal where
    val (_,r) = valueAt1 <$> now <*> (swave <$> derefM r)

instance Valueable VProc Signal where
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

basic_sig_update mv mr = do
    v <- (mv >>= val)
    x <- mr
    updateM (\s -> s{ swave = wconst v }) (snd x)
    ccheck x
    return x

basic_var_update mv mr = do
    v <- (mv >>= val)
    x <- mr
    updateM (\var -> var{ vval = v }) (snd x)
    ccheck x
    return x

instance (MonadPtr m, Valueable (Elab m) v) => Assignable (Elab m) Signal v where
    assign = basic_sig_update

instance (MonadPtr m, Valueable (Elab m) v) => Assignable (Elab m) Variable v where
    assign = basic_var_update

instance (Valueable VProc v) => Assignable VProc Variable v where
    assign = basic_var_update

instance (Valueable VAssign v) => Assignable VAssign Signal v where
    assign mv mr = do
        a <- Assignment <$> mr <*> (PW <$> ask <*> (wconst <$> (val =<< mv)))
        modify (add_assignment a)
        return (acurr a)

-- Constrained 

instance (MonadPtr m) => Constrained m Signal where
    ccheck (t,r) = derefM r >>= \s -> ccfail_ifnot s (in_range_w t (swave s))

instance (MonadPtr m) => Constrained m Variable where
    ccheck (t,r) = derefM r >>= \v -> ccfail_ifnot v (in_range t (vval v))

