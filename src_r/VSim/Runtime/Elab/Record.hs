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

instance (Representable x) => Representable (RecordT x) where
    type SR (RecordT x) = Ptr (RecordR (SR x))
    type VR (RecordT x) = Ptr (RecordR (VR x))

instance (MonadElab m, Createable m t r) => Createable m (RecordT t) (Ptr (RecordR r)) where
    alloc n (RecordT t) = alloc n t >>= allocM . RecordR n

instance (Representable a, Representable b) =>
         Representable ((String, a) :-: b)  where
    type SR ((String, a) :-: b) = ((a, SR a), SR b)
    type VR ((String, a) :-: b) = ((a, VR a), VR b)

instance (MonadElab m, Createable m t1 a, Createable m t2 b)
    => Createable m ((String, t1) :-: t2) ((t1,a), b) where
        alloc n ((fn, t1) :-: t2) = do
            x <- alloc (printf "%s.%s" n fn) t1
            r <- alloc n t2
            return ((t1,x), r)

instance Representable ()  where
    type SR () = ()
    type VR () = ()

instance (MonadElab m) => Createable m () () where
    alloc n () = return ()

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

instance (MonadPtr m) => Assignable (Elab m) (Record t x) (Record t x) where
    assign = undefined

