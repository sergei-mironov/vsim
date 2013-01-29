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

import VSim.Runtime.Waveform
import VSim.Runtime.Monad
import VSim.Runtime.Class
import VSim.Runtime.Ptr
import VSim.Runtime.Elab.Prim
import VSim.Runtime.Elab.Class

{- Representable -}

instance (Representable x) => Representable (RecordT x) where
    type SR (RecordT x) = RecordR (SR x)
    type VR (RecordT x) = RecordR (VR x)
    type FR (RecordT x) = RecordR (FR x)

instance (Representable a, Representable b) =>
         Representable ((String, a), b)  where
    type SR ((String, a), b) = (Ptr (SR a), SR b)
    type VR ((String, a), b) = (Ptr (VR a), VR b)
    type FR ((String, a), b) = (FR a, FR b)

instance Representable ()  where
    type SR () = ()
    type VR () = ()
    type FR () = ()

{- Createable -}

fieldname n fn = printf "%s.%s" n fn

instance (MonadElab m, Createable m t r)
    => Createable m (RecordT t) (RecordR r) where
        alloc n (RecordT t) = do
            r <- vr <$> alloc n t
            return (Value n (RecordT t) (RecordR r))

        fixup (Value n (RecordT t) (RecordR r)) = do
            r' <- vr <$> fixup (Value n t r)
            return (Value n (RecordT t) (RecordR r'))

instance (MonadElab m, Createable m t1 a, Createable m t2 b)
    => Createable m ((String, t1), t2) (Ptr a, b) where

        alloc n t@((fn, t1), t2) = do
            let en = fieldname n fn
            er <- (vr <$> alloc en t1)
            ptr_er <- allocM er
            r <- vr <$> alloc n t2
            return (Value n t (ptr_er,r))

        fixup (Value n t@((fn,t1),t2) (ptr_er,r)) = do
            let en = fieldname n fn
            er <- derefM ptr_er
            er' <- vr <$> fixup (Value en t1 er)
            writeM ptr_er er'
            r' <- vr <$> fixup (Value n t2 r)
            return (Value n t (ptr_er,r'))

instance (MonadElab m)
    => Createable m () () where
        alloc n () = return (Value n () ())
        fixup x = return x

field fsel mx = mx >>= \x -> field' fsel x

field' fsel (Value n (RecordT t) (RecordR r)) = do
    let (en,et) = (fst fsel) t
    let ptr_er = (snd fsel) r
    er <- derefM ptr_er
    return (Value en et er)

setfld fsel agg rec@(Value n (RecordT t) (RecordR r)) = do
    let (fn,et) = (fst fsel) t
    let ptr_er = (snd fsel) r
    let en = fieldname n fn
    er <- derefM ptr_er
    (Value en' et' er') <- agg (Value en et er)
    writeM ptr_er er'
    return rec

-- instance (MonadPtr m) => Assignable (Elab m) (Record t x) (Record t x) where
--     assign = error "record assignment is undefined still"


-- | Returns record type and the set of accessors to it's fields
alloc_record_type x = return (RecordT x, accessors) where
    -- FIXME: support up to 16 fileds. Oh, make me unsee that.
    -- This is tuple of pairs. Each element of pair is an accessor. First one is
    -- used to convert record type to element type. Second element is used to
    -- convert record runtime part to field runtime part. See index' for
    -- details.
    accessors
        =   (fst,
             fst)
        :-: (fst . snd ,
             fst . snd )
        :-: (fst . snd . snd ,
             fst . snd . snd )
        :-: (fst . snd . snd . snd ,
             fst . snd . snd . snd )
        :-: (fst . snd . snd . snd . snd ,
             fst . snd . snd . snd . snd )
        :-: (fst . snd . snd . snd . snd . snd ,
             fst . snd . snd . snd . snd . snd )
        :-: (fst . snd . snd . snd . snd . snd . snd ,
             fst . snd . snd . snd . snd . snd . snd )
        :-: (fst . snd . snd . snd . snd . snd . snd . snd ,
             fst . snd . snd . snd . snd . snd . snd . snd )
        :-: (fst . snd . snd . snd . snd . snd . snd . snd . snd ,
             fst . snd . snd . snd . snd . snd . snd . snd . snd )
        :-: (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd ,
             fst . snd . snd . snd . snd . snd . snd . snd . snd . snd )
        :-: (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd ,
             fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd )
        :-: (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd ,
             fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd )
        :-: (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd ,
             fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd )
        :-: (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd ,
             fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd )
        :-: (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd ,
             fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd )
        :-: (fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd ,
             fst . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd . snd )




