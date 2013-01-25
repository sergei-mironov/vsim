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

defval method x = return x

-- | Something that can be created in monad m, having type t
class (MonadPtr m) => Createable m t method x where
    alloc :: String -> t -> method -> Agg m method (Value t x) -> m (Value t x)

-- | States that @v value can be assigned to @c in the monad @m.
-- Implementation has a choise: it can either perform inplace monadic
-- actions or ask the runtime to perform signal update by returning a Plan.
class (MonadPtr m) => Assignable m v method target where
    assign' :: v -> method -> target -> m target
    assign :: m v -> method -> target -> m target 
    assign mv m t = mv >>= \v -> assign' v m t

-- | Class of accessable containers
class (MonadPtr m) => Accessable m container method item | container -> item where
    access' :: Int -> (Agg m method item) -> method -> container -> m container
    access :: m Int -> (Agg m method item) -> method -> container -> m container 
    access mi a m c = mi >>= \i -> access' i a m c

    access_all :: (Agg m method item) -> method -> container -> m container

