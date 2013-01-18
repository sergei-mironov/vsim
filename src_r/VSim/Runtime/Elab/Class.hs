{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}

-- | Contains some generic typeclsses, used by the Runtime
module VSim.Runtime.Elab.Class where

import Control.Applicative
import Control.Monad

import VSim.Runtime.Monad
import VSim.Runtime.Ptr

-- | States that a value can be assigned to a container in a specific monad.
-- For etample, Ints could be assigned to Signals, x can be assigned to the
-- arrays of x
class (Monad m) => Assignable m c v where
    assign :: m v -> m c -> m Plan


