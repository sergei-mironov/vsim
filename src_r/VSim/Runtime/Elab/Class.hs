{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}

-- | Contains some generic typeclsses, used by the Runtime
module VSim.Runtime.Elab.Class where

import Control.Applicative
import Control.Monad

import VSim.Runtime.Monad
import VSim.Runtime.Ptr

-- | States that @v value can be assigned to @c in the monad @m.
-- Implementation has a choise: it can either perform inplace monadic
-- actions or ask the runtime to perform signal update by returning a Plan.
class (Monad m) => Assignable m c v where
    assign :: m v -> m c -> m Plan


