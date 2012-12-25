{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module VSim.Runtime.Elab.Record where

import Control.Applicative
import Control.Monad
import Text.Printf
import Data.IntMap as IntMap
import Data.NestedTuple

import VSim.Runtime.Monad
import VSim.Runtime.Class
import VSim.Runtime.Ptr
import VSim.Runtime.Elab.Prim

instance (MonadElab m, Createable m x) => Createable m (RecordT x) where
    type SR (RecordT x) = Ptr (RecordR (SR x))
    type VR (RecordT x) = Ptr (RecordR (VR x))
    alloc_signal n c@(RecordT t) f = do
        (_, b) <- alloc_signal n t id
        f $ pairM (pure c) (allocM $ RecordR n b)
    alloc_variable n c@(RecordT t) f = do
        (_, b) <- alloc_variable n t id
        f $ pairM (pure c) (allocM $ RecordR n b)

instance (MonadElab m, Createable m a, Createable m b) =>
         Createable m ((String, a) :-: b)  where
    type SR ((String, a) :-: b) = ((a, SR a), SR b)
    type VR ((String, a) :-: b) = ((a, VR a), VR b)
    alloc_signal n c@((fn,ta) :-: tb) f = do
        (_, sa) <- alloc_signal (printf "%s.%s" n fn) ta id
        (_, sb) <- alloc_signal n tb id
        f $ constrM c $ return ((ta,sa), sb)
    alloc_variable n c@((fn,ta) :-: tb) f = do
        (_, sa) <- alloc_variable (printf "%s.%s" n fn) ta id
        (_, sb) <- alloc_variable n tb id
        f $ constrM c $ return ((ta,sa), sb)

instance (Monad m) => Createable m ()  where
    type SR () = ()
    type VR () = ()
    alloc_signal _ _ _ = return ((),())
    alloc_variable _ _ _ = return ((),())

-- | Returns record type and the set of accessors to it's fields
alloc_record_type x = return (RecordT x, accessors) where
    -- FIXME: support up to 16 fileds. Oh, make me unsee that.
    accessors
        =   (fst)
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

field :: (MonadPtr m) => Accessor r f -> m (Record x r) -> m f
field fsel mx = (fsel . rtuple) <$> (derefM =<< (snd <$> mx))

setfld :: (MonadPtr m) => Accessor r f -> Assigner m f -> (Record x r) -> m (Record x r)
setfld fs f r = f (field fs (pure r)) >> return r

