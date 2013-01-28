{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FunctionalDependencies #-}

-- | Contains some generic typeclsses, used by the Runtime
module VSim.Runtime.Elab.Class where

import Control.Applicative
import Control.Monad

import VSim.Runtime.Class
import VSim.Runtime.Monad
import VSim.Runtime.Ptr

defval x = return x

-- | Something that can be created in monad m, having type t
class (MonadPtr m) => Createable m t x where
    alloc :: String -> t -> Agg m (Value t x) -> m (Value t x)

-- | States that @v value can be assigned to @c in the monad @m.
-- Implementation has a choise: it can either perform inplace monadic
-- actions or ask the runtime to perform signal update by returning a Plan.
class (MonadPtr m) => Assignable m v target where
    assign' :: v -> target -> m target

assign :: (Assignable m v target, Parent m mi)
    => mi v -> target -> m target 
assign mv t = (hug mv) >>= \v -> assign' v t

-- | Class of accessable containers
class (MonadPtr m) => Accessable m container item | container -> item where
    access' :: Int -> (Agg m item) -> container -> m container
    access_all :: (Agg m item) -> container -> m container

access :: (Accessable m container item, Parent m mi)
    => mi Int -> (Agg m item) -> container -> m container 
access mi a c = (hug mi) >>= \i -> access' i a c

