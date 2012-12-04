{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DeriveDataTypeable #-}

module VSim.Data.Int128
    ( Int128
    ) where

import Data.Typeable
import Data.Generics
import Data.Bits
import Data.Word
import Data.Int
import Foreign.Storable
import Foreign.Ptr

-- TODO: надо сделать честный Int128 со всеми ошибками переполнения

data Int128 = Int128 {-# UNPACK #-} !Int64 {-# UNPACK #-} !Word64
    deriving(Data, Typeable)

instance Eq Int128 where
    Int128 ha la == Int128 hb lb = ha == hb && la == lb

instance Ord Int128 where
--     compare a b = compare (toInteger a) (toInteger b)
    compare (Int128 ha la) (Int128 hb lb) =
        let r = case compare ha hb of
                    EQ -> compare la lb
                    x  -> x
        in r `seq` r


--     (<) :: a -> a -> Bool
--     (>=) :: a -> a -> Bool
--     (>) :: a -> a -> Bool
--     (<=) :: a -> a -> Bool
--     max :: a -> a -> a
--     min :: a -> a -> a

instance Num Int128 where
    (+) = lift (+)
    (*) = lift (*)
    (-) = lift (-)
    negate = lift1 negate
    abs = lift1 abs
    signum = lift1 signum
    fromInteger i = Int128 ((fromInteger $ (i `shiftR` 64)) .&. (-1))
                           ((fromInteger $ i) .&. (-1))

instance Real Int128 where
    toRational = fromInteger . toInteger

instance Enum Int128 where
    succ x
        | x == maxBound = error "Int128.succ maxBound"
        | otherwise     = x + 1
    pred x
        | x == minBound = error "Int128.pred minBound"
        | otherwise     = x - 1
    toEnum = fromInteger . toEnum
    fromEnum = fromEnum . toInteger
    enumFrom x             = map fromInteger [toInteger x ..]
    enumFromThen x y       = map fromInteger [toInteger x, toInteger y ..]
    enumFromTo x y         = map fromInteger [toInteger x .. toInteger y]
    enumFromThenTo x1 x2 y = map fromInteger [toInteger x1,
                                              toInteger x2 .. toInteger y]

instance Integral Int128 where
    quot = lift quot
    rem = lift rem
    div = lift div
    mod = lift mod
    quotRem a b = let !(q, r) = quotRem (toInteger a) (toInteger b) in
                  (fromInteger q, fromInteger r)
--     divMod :: a -> a -> (a, a)
    toInteger (Int128 h l) = (toInteger h `shiftL` 64) .|. toInteger l

{-# INLINE lift #-}
lift f a b = fromInteger (f (toInteger a) (toInteger b))

{-# INLINE lift1 #-}
lift1 f a = fromInteger (f (toInteger a))

instance Bounded Int128 where
    minBound = -(2^127)
    maxBound = 2^127-1

instance Show Int128 where
    showsPrec d = showsPrec d . toInteger
instance Read Int128 where
    readsPrec d s = map (\(a, r) -> (fromInteger a, r)) $ readsPrec d s

instance Storable Int128 where
    sizeOf _ = 16
    alignment _ = 8
    peek ptr =
        do h <- peek        (castPtr ptr)
           l <- peekByteOff (castPtr ptr) 8
           return $ Int128 h l
    poke ptr (Int128 h l) =
        do poke        (castPtr ptr)   h
           pokeByteOff (castPtr ptr) 8 l

