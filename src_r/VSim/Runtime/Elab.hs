{-# LANGUAGE Rank2Types #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module VSim.Runtime.Elab (
      module VSim.Runtime.Elab.Class
    , module VSim.Runtime.Elab.Prim
    , module VSim.Runtime.Elab.Array
    , module VSim.Runtime.Elab.Record
    , alloc_signal
    , alloc_variable
    , alloc_constant
    , alloc_named_constant
    , alloc_process
    , alloc_process_let
    , alloc_subtype
    , assume_subtype_of
    , alloc_ranged_type
    , alloc_unranged_type
    , alloc_range
    , alloc_urange
    , alloc_enum_type
    , aggregate
    , alloc_function
    , alloc_port
    ) where

import Control.Monad.Trans
import Control.Monad.State
import Control.Applicative
import Data.IntMap as IntMap
import Data.IORef
import Data.Range
import Data.Unique
import Text.Printf
import System.IO
import System.Random

import VSim.Runtime.Waveform
import VSim.Runtime.Process
import VSim.Runtime.Monad
import VSim.Runtime.Class
import VSim.Runtime.Ptr
import VSim.Runtime.Elab.Class
import VSim.Runtime.Elab.Prim
import VSim.Runtime.Elab.Array
import VSim.Runtime.Elab.Record

alloc_function f = return f

aggregate :: (MonadPtr m) => [a -> m a] -> a -> m a
aggregate fs a = loopM a fs $ \a f -> f a

-- | Allocates unconstrained range
alloc_urange :: (MonadElab m) => m RangeT
alloc_urange = pure UnconstrT

alloc_range :: (MonadElab m) => m Int -> m Int -> m RangeT
alloc_range ml mu = RangeT <$> ml <*> mu

alloc_ranged_type :: (MonadElab m) => m RangeT -> m (PrimitiveT Int)
alloc_ranged_type mr = mkprim <$> mr where
    mkprim (RangeT l u) = PrimitiveT l u
    mkprim (UnconstrT) = PrimitiveT minBound maxBound

alloc_unranged_type :: (MonadElab m) => m (PrimitiveT Int)
alloc_unranged_type = return unranged

alloc_signal :: (Createable (Elab m) t (SR t))
    => String -> t -> Agg (Clone (Elab m)) (Value t (SR t)) -> (Elab m) (Value t (SR t))
alloc_signal n t f = alloc n t >>= unClone . f >>= fixup

alloc_variable :: (Createable (Elab m) t (VR t))
    => String -> t -> Agg (Clone (Elab m)) (Value t (VR t)) -> (Elab m) (Value t (VR t))
alloc_variable n t f = alloc n t >>= unClone . f >>= fixup

alloc_port :: (Createable (Elab m) t (SR t))
    => String -> t -> Agg (Link m) (Value t (SR t)) -> (Elab m) (Value t (SR t))
alloc_port n t f = alloc n t >>= unLink . f >>= fixup

alloc_named_constant :: (MonadElab m) => String -> m Int -> m Int
alloc_named_constant _ v = v

alloc_constant :: (MonadPtr m, Createable m t (CR t))
    => t -> Agg (Clone m) (Value t (CR t)) -> m (Value t (CR t))
alloc_constant t f = alloc [] t >>= unClone . f >>= fixup

-- | Register the process in memory. Updates list of signal reactions
alloc_process :: (MonadElab m)
    => String -> [Signal Int] -> ProcessHandler -> m (Ptr Process)
alloc_process n ss h = do
    let encycle [] = forever h
        encycle xs = forever (h >> wait_on (Prelude.map vr xs))
    u <- liftIO (hashUnique <$> newUnique)
    p <- allocM (Process n (encycle ss) Nothing [] u)
    modify_mem $ \(Memory rs ps) -> Memory rs (p:ps)
    return p

alloc_process_let :: (MonadElab m)
    => String -> [Signal Int] -> m ProcessHandler -> m (Ptr Process)
alloc_process_let n ss lh = lh >>= alloc_process n ss


-- | Allocate a subtype for a type t. Just create new type for now..
alloc_subtype :: (MonadElab m) => m RangeT -> (PrimitiveT Int) -> m (PrimitiveT Int)
alloc_subtype mr _ = alloc_ranged_type mr

assume_subtype_of :: (MonadElab m, Subtypeable t, Show t) => t -> Value t x -> m (Value t x)
assume_subtype_of t' x@(Value n t r) = do
    when (not $ t `valid_subtype_of` t') (
        pfail2 "type convertion from %s to %s failed" (show t) (show t'))
    return x

alloc_enum_type :: (MonadElab m) => Int -> m (PrimitiveT Int, [Int])
alloc_enum_type len = let (l,r) = (0, len-1) in return (PrimitiveT l r, [l..r])

{- Mappable -}

-- instance (MonadPtr m) => Mappable (Elab m) PrimitiveT Signal where
--     portmap t ms = ms >>= return

-- instance (MonadPtr m) => Mappable (Elab m) PrimitiveT Int where
--     portmap t mx = alloc_signal "tmp" t (assign mx)


-- alloc_portmap :: (MonadElab m, Createable m t (SR t), Mappable m t x)
--     => t -> m x -> m (SR t)
-- alloc_portmap t mx = portmap (alloc_signal "")

