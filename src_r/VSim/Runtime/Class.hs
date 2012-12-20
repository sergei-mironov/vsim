{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

-- | Contains some generic typeclsses, used by the Runtime
module VSim.Runtime.Class where

class Createable m x where
    -- | Signal representation
    type SR x :: *
    -- | Allocate signal for this type representation
    alloc_signal :: String -> x -> (m (SR x) -> m (SR x)) -> m (SR x)
    -- | Varaiable representation
    type VR x :: *
    -- | Allocate variable for this type representation
    alloc_variable :: String -> x -> (m (VR x) -> m (VR x)) -> m (VR x)

-- | States that a value can be assigned to a container in a specific monad.
-- For example, Ints could be assigned to Signals, x can be assigned to the
-- arrays of x
class (Monad m) => Assignable m c v where
    assign :: m v -> m c -> m c

type Assigner m c = m c -> m c

class Cloneable m x where
    clone :: x -> m x

class Constrained x where
    within :: x -> Bool

class Imageable m x t where
    t_image :: m x -> t -> m String

