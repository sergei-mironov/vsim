{-# LANGUAGE Rank2Types #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module VSim.Runtime.Elab (
      module VSim.Runtime.Elab.Prim
    , module VSim.Runtime.Elab.Array
    , module VSim.Runtime.Elab.Record
    , module VSim.Runtime.Elab.Function
    , alloc_constant
    , alloc_process
    , alloc_process_let
    , alloc_function
    , associate
    ) where

import Control.Monad.Trans
import Control.Monad.State
import Control.Applicative
import Data.IntMap as IntMap
import Data.IORef
import Text.Printf
import System.IO
import System.Random

import VSim.Runtime.Waveform
import VSim.Runtime.Process
import VSim.Runtime.Monad
import VSim.Runtime.Class
import VSim.Runtime.Ptr
import VSim.Runtime.Elab.Prim
import VSim.Runtime.Elab.Array
import VSim.Runtime.Elab.Record
import VSim.Runtime.Elab.Function

-- | Registers process in the memory. Updates list of signal's reactions
alloc_process :: (MonadElab m)
    => String -> [(t, Ptr Signal)] -> ProcessHandler -> m (Ptr Process)
alloc_process n ss h = do
    let encycle [] = forever h
        encycle xs = forever (h >> wait_on (Prelude.map snd xs))
    p <- allocM (Process n (encycle ss) Nothing [])
    modify_mem $ \(Memory rs ps) -> Memory rs (p:ps)
    return p

alloc_process_let :: (MonadElab m)
    => String -> [(t, Ptr Signal)] -> m ProcessHandler -> m (Ptr Process)
alloc_process_let n ss lh = lh >>= alloc_process n ss

alloc_constant :: (MonadElab m) => String -> m Int -> m Int
alloc_constant _ v = v

instance (MonadPtr m, Valueable (Elab m) v)
    => Assignable (Elab m) (PrimitiveT, Ptr Signal) v where
    assign mv mr = do
        v <- (mv >>= val)
        (t,r) <- mr
        when (not $ within (t,v)) $ do
            fail ("assign: constraint failure")
        updateM (\s -> s{ swave = wconst v }) r
        return (t,r) 

instance (MonadPtr m, Valueable (Elab m) v)
    => Assignable (Elab m) (PrimitiveT, Ptr Variable) v where
    assign mv mr = do
        v <- (mv >>= val)
        (t,r) <- mr
        when (not $ within (t,v)) $ do
            fail ("assign: constraint failure")
        updateM (\var -> var{ vval = v }) r
        return (t,r) 

instance (MonadPtr m)
    => Assignable (Elab m) (Array t x) (Array t x) where
    assign = undefined

instance (MonadPtr m)
    => Assignable (Elab m) (Record t x) (Record t x) where
    assign = undefined

alloc_function :: (MonadElab m) => String -> FElab -> m Function
alloc_function n h = Function <$> (pure n) <*> (pure h)

-- FIXME: check types, throw errors if they are not compatible
associate :: (MonadElab m) => t -> m (t,x) -> m (t,x)
associate t' mx = mx >>= \(t,x) -> return (t',x)

