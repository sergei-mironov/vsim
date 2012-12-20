{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module VSim.Runtime.Elab.Array where

import Control.Applicative
import Control.Monad
import Text.Printf
import Data.IntMap as IntMap

import VSim.Runtime.Monad
import VSim.Runtime.Class
import VSim.Runtime.Ptr
import VSim.Runtime.Elab.Prim


-- | ArrayT of IntType generates Arrays of this type
instance (MonadElab m) => Createable m (ArrayT PrimitiveT) where
    type SR (ArrayT PrimitiveT) = Ptr (Array PrimitiveT (Ptr Signal))
    type VR (ArrayT PrimitiveT) = Ptr (Array PrimitiveT (Ptr Variable))
    alloc_signal = alloc_array_signal
    alloc_variable = alloc_array_variable

-- | ArrayT of ArrayT generates Array of Arrays
instance (MonadElab m, Createable m (ArrayT t)) => Createable m (ArrayT (ArrayT t)) where
    type SR (ArrayT (ArrayT t)) = Ptr (Array (ArrayT t) (SR (ArrayT t)))
    type VR (ArrayT (ArrayT t)) = Ptr (Array (ArrayT t) (VR (ArrayT t)))
    alloc_signal = alloc_array_signal
    alloc_variable = alloc_array_variable

alloc_array_type :: (MonadElab m) => m Int -> m Int -> t -> m (ArrayT t)
alloc_array_type mb me t = ArrayT <$> (pure t) <*> mb <*> me

-- | Allocates array of signals from the memory
alloc_array_signal n a f = do
    let indexes = [(abegin a) .. (aend a)]
    pairs <- forM indexes (\i -> do
        let sn = n ++ (printf "[%d]" i)
        s <- alloc_signal sn (aconstr a) id
        return (i,s))
    f $ allocM (Array n (IntMap.fromList pairs) a)

-- | Allocates array of variables
alloc_array_variable n a f = do
    let indexes = [(abegin a) .. (aend a)]
    pairs <- forM indexes (\i -> do
        let sn = n ++ (printf "[%d]" i)
        s <- alloc_variable sn (aconstr a) id
        return (i,s))
    f $ allocM (Array n (IntMap.fromList pairs) a)

