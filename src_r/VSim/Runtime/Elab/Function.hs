{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module VSim.Runtime.Elab.Function where

import Control.Applicative
import Control.Monad
import Data.IntMap as IntMap
import Data.NestedTuple
import Text.Printf

import VSim.Runtime.Monad
import VSim.Runtime.Class
import VSim.Runtime.Ptr
import VSim.Runtime.Elab.Prim

{-
data In x = In x
data Out x = Out x
data InOut x = InOut x

class (MonadProc m) => Arglike m x where
    type UA m x :: *
    arg :: (x -> m z) -> UA m x -> m z

instance (MonadProc m, Cloneable m x) => Arglike m (In x) where
    type UA m (In x) = m x
    arg f mx = mx >>= f . In

-- instance (MonadProc m, Cloneable m x) => Arglike m (Out x) where
--     type UA (Out x) = x
--     arg f x = f (Out x)

instance (MonadProc m, Arglike m x, Arglike m y) => Arglike m (x :-: y) where
    type UA m (x :-: y) = (UA m x :-: UA m y)
    arg f (x :-: y) = arg fx x where
        fx ax = arg fy y where
            fy ay = f (ax :-: ay)

-}

(<<) :: Monad m => (a -> m b) -> m a -> m b
(<<) = (=<<)
infixl 1 <<


