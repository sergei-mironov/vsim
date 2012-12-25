{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module VSim.Runtime.Elab.Prim where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans
import Data.IntMap as IntMap
import Text.Printf
import System.Random

import VSim.Runtime.Monad
import VSim.Runtime.Class
import VSim.Runtime.Ptr
import VSim.Runtime.Waveform

instance (MonadElab m) => Createable m PrimitiveT where
    type SR PrimitiveT = Ptr Signal
    type VR PrimitiveT = Ptr Variable

    alloc_signal n t f = do
        i <- rnd' t
        r <- allocM (Signal n (wconst i) 0 [])
        modify_mem $ \(Memory rs ps) -> Memory (r:rs) ps
        f $ pure (t,r)

    alloc_variable n t f = do
        i <- rnd' t
        r <- allocM (Variable n i)
        f $ pure (t,r)

rnd' :: (MonadIO m) => PrimitiveT -> m Int
rnd' c = liftIO $ randomRIO (lower c, upper c)

alloc_ranged_type :: (MonadElab m) => m Int -> m Int -> m PrimitiveT
alloc_ranged_type ma mb = ranged <$> ma <*> mb

alloc_unranged_type :: (MonadElab m) => m PrimitiveT
alloc_unranged_type = return unranged

instance (MonadPtr m) => Valueable m (t, Ptr Variable) where
    val (_,r) = vval <$> derefM r

instance Valueable VAssign (t, Ptr Signal) where
    val (_,r) = valueAt1 <$> now <*> (swave <$> derefM r)

-- FIXME: I am not sure that it is ok to ask minBound in Elab monad
instance (MonadPtr m) => Valueable (Elab m) (t, Ptr Signal) where
    val (_,r) = valueAt <$> (pure minBound) <*> (swave <$> derefM r)

