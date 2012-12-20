{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module VSim.Runtime.Elab.Record where

import Control.Monad
import Text.Printf
import Data.IntMap as IntMap
import Data.NestedTuple

import VSim.Runtime.Monad
import VSim.Runtime.Class
import VSim.Runtime.Ptr
import VSim.Runtime.Elab.Prim

newtype RecordT x = RecordT x
    deriving(Show)

instance (MonadElab m, Createable m x) => Createable m (RecordT x) where
    type SR (RecordT x) = Ptr (Record (SR x))
    type VR (RecordT x) = Ptr (Record (VR x))
    alloc_signal n (RecordT t) f = do
        b <- alloc_signal n t id
        f $ allocM $ Record n b
    alloc_variable n (RecordT t) f = do
        b <- alloc_variable n t id
        f $ allocM $ Record n b

instance (MonadElab m, Createable m a, Createable m b) =>
         Createable m ((String, a) :-: b)  where
    type SR ((String, a) :-: b) = (SR a, SR b)
    type VR ((String, a) :-: b) = (VR a, VR b)
    alloc_signal n ((fn,ta) :-: tb) f = do
        sa <- alloc_signal (printf "%s.%s" n fn) ta id
        sb <- alloc_signal n tb id
        f $ return (sa, sb)
    alloc_variable n ((fn,ta) :-: tb) f = do
        sa <- alloc_variable (printf "%s.%s" n fn) ta id
        sb <- alloc_variable n tb id
        f $ return (sa, sb)

instance (Monad m) => Createable m ()  where
    type SR () = ()
    type VR () = ()
    alloc_signal _ _ _ = return ()
    alloc_variable _ _ _ = return ()

alloc_record_type x = return (RecordT x, accessors) where
    -- FIXME: support up to 16 fileds. Oh, make me unsee that.
    accessors
        =  (fst)
        :-: (fst . snd)
        :-: (fst . snd . snd)
        :-: (fst . snd . snd . snd)
        :-: (fst . snd . snd . snd . snd)
        :-: (fst . snd . snd . snd . snd . snd)
        :-: (fst . snd . snd . snd . snd . snd . snd)
        :-: (fst . snd . snd . snd . snd . snd . snd . snd)
        :-: (fst . snd . snd . snd . snd . snd . snd . snd . snd)
        :-: (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd)
        :-: (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd)
        :-: (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd)
        :-: (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd)
        :-: (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd)
        :-: (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd)
        :-: (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd)

