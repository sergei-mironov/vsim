{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE GADTs #-}

-- | Contains some generic typeclsses, used by the Runtime
module VSim.Runtime.Elab.Class where

import Control.Applicative
import Control.Monad

import VSim.Runtime.Class
import VSim.Runtime.Monad
import VSim.Runtime.Ptr

-- | Something that can be created in monad m, having type t
class Createable m t method tgt where
    alloc :: String -> t -> method -> Agg m method tgt -> m tgt

-- | States that @v value can be assigned to @c in the monad @m.
-- Implementation has a choise: it can either perform inplace monadic
-- actions or ask the runtime to perform signal update by returning a Plan.
class (Monad m) => Assignable m v method tgt where
    assign :: v -> method -> tgt -> m tgt

loopM a b f = foldM f a b

