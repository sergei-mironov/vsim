{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}

-- | Contains some generic typeclsses, used by the Runtime
module VSim.Runtime.Class where

import Control.Applicative
import Control.Monad

-- | Createable types are those who can be created as signals or variables.
-- Resulting entity is a pair which contains the type and runtime representation
-- os signal or variable
class Createable m t where
    -- | Signal representation
    type SR t :: *
    alloc_signal :: String -> t -> (m (t,SR t) -> m (t,SR t)) -> m (t,SR t)
    -- | Varaiable representation
    type VR t :: *
    alloc_variable :: String -> t -> (m (t,VR t) -> m (t,VR t)) -> m (t,VR t)


constrM :: (Monad m, Applicative m) => t -> m y -> m (t,y)
constrM t my = (\t y -> (t,y)) <$> (pure t) <*> my

pairM ::  (Monad m, Applicative m) => m t -> m y -> m (t,y)
pairM mt my = (\t y -> (t,y)) <$> mt <*> my

-- | States that a value can be assigned to a container in a specific monad.
-- For etample, Ints could be assigned to Signals, x can be assigned to the
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

class (Monad m) => Valueable m x where
    val :: x -> m Int

instance (Monad m) => Valueable m Int where
    val r = return r

-- class (Monad m) => Valueables m x
-- instance (Valueable m a, Valueable m b) => Valueables m (a,b)
-- instance (Valueable m a, Valueable m b, Valueable m c) => Valueables m (a,b,c)
-- class Signalable x

