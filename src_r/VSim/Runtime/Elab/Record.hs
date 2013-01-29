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
    type SR ((String, a), b) = (SR a, SR b)
    type VR ((String, a), b) = (VR a, VR b)
    type FR ((String, a), b) = (FR a, FR b)

instance Representable ()  where
    type SR () = ()
    type VR () = ()
    type FR () = ()

{- Createable -}

fieldname n fn = printf "%s.%s" n fn

instance (MonadElab m, Createable m t r)
    => Createable m (RecordT t) (RecordR r) where
        alloc (RecordT t) = do
            r <- ur <$> alloc t
            return (Value_u (RecordT t) (RecordR r))

        fixup n (Value_u (RecordT t) (RecordR r)) = do
            r' <- vr <$> fixup n (Value_u t r)
            return (Value (RecordT t) n (RecordR r'))

instance (MonadElab m, Createable m t1 a, Createable m t2 b)
    => Createable m ((String, t1), t2) ((t1,a), b) where

        alloc t@((fn, t1), t2) = do
            x <- ur <$> alloc t1
            r <- ur <$> alloc t2
            return (Value_u t ((t1,x),r))

        fixup n (Value_u t@((fn,t1),t2) ((_,x),r)) = do
            x' <- vr <$> fixup (fieldname n fn) (Value_u t1 x)
            r' <- vr <$> fixup n (Value_u t2 r)
            return (Value t n ((t1,x'),r'))

instance (MonadElab m)
    => Createable m () () where
        alloc () = return (Value_u () ())
        fixup n (Value_u () ()) = return (Value () n ())

-- | Returns record type and the set of accessors to it's fields
alloc_record_type x = return (RecordT x, accessors) where
    -- FIXME: support up to 16 fileds. Oh, make me unsee that.
    -- This is tuple of pairs. Each element of pair is an accessor. First one is
    -- used to convert record type to element type. Second element is used to
    -- convert record runtime part to field runtime part. See index' for
    -- details.
    accessors
        =   (fst, fst)
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

field fsel mx = mx >>= \x -> field' fsel x

field' fsel (Value (RecordT t) n (RecordR r)) = do
    let (en,et) = (fst fsel) t
    let er = (snd fsel) r
    return (Value et en er)

-- instance (MonadPtr m) => Fieldable m Value_u (RecordT t) (RecordR r) where
--     setfield' fsel rec@(Value_u (RecordT t) (RecordR r)) agg = do
--         let (en,et) = (fst fsel. un) (t)
--         let er = (snd fsel) r
--         (Value_u et' er') <- agg (Value_u et er)
--         return rec -- FIXME

-- setfld :: (MonadPtr m) => Accessor r f -> Assigner m f -> (Record x r) -> m Plan
-- setfld fs f r = f (field fs (pure r))

-- instance (MonadPtr m) => Assignable (Elab m) (Record t x) (Record t x) where
--     assign = error "record assignment is undefined still"




