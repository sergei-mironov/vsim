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

-- data Method = Clone | Map
--     deriving(Show)

class Untypeable t where
    type TY t :: *
    type RU t :: *

instance Untypeable (Value t a) where
    type TY (Value t a) = t
    type RU (Value t a) = a

class (MonadElab m, Representable (TY dst), Untypeable dst)
    => Createable0 m dst where
        alloc0 :: String -> TY dst -> m dst

-- | Something that can be created in monad m, having type t
class (Createable0 m dst)
    => Createable m dst src where
        alloc :: String -> TY dst -> src -> m dst

type Agg m x r = x -> m r

-- | Something that can be created in monad m, having type t
class (Createable0 m dst)
    => CreateableA m dst where
        allocA :: String -> TY dst -> [Agg m dst r] -> m dst

-- | States that @v value can be assigned to @c in the monad @m.
-- Implementation has a choise: it can either perform inplace monadic
-- actions or ask the runtime to perform signal update by returning a Plan.
class (Monad m) => Assignable m c v where
    assign :: m v -> m c -> m Plan

-- class (Createable m v x) => Accessable m (Array t e) x ()

class Accessable m a x r where
    access :: Int -> x -> a -> m r


