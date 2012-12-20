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
    alloc_signal = alloc_primitive_signal
    alloc_variable = alloc_primitive_variable

-- | Allocates a signal from the memory
alloc_primitive_signal n c f = do
    i <- rnd' c
    r <- f $ allocM (Signal n (wconst i) 0 c [])
    modify_mem $ \(Memory rs ps) -> Memory (r:rs) ps
    return r

-- | Allocates variable from the memory
alloc_primitive_variable :: (MonadElab m)
    => String -> PrimitiveT -> Assigner m (Ptr Variable) -> m (Ptr Variable)
alloc_primitive_variable n c f = rnd' c >>= \i -> f $ allocM (Variable n i c)

rnd' :: (MonadIO m) => PrimitiveT -> m Int
rnd' c = liftIO $ randomRIO (lower c, upper c)

alloc_ranged_type :: (MonadElab m) => m Int -> m Int -> m PrimitiveT
alloc_ranged_type ma mb = ranged <$> ma <*> mb

alloc_unranged_type :: (MonadElab m) => m PrimitiveT
alloc_unranged_type = return unranged

