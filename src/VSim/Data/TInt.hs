{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module VSim.Data.TInt where

import Data.Int
import Data.Bits
import Foreign.Storable
import Text.Printf

newtype TInt = TInt { tintToInt32 :: Int32 }
    deriving (Eq, Ord, Num, Enum, Real, Integral, Storable, Bounded, Bits, PrintfArg)

instance Show TInt where
    showsPrec d = showsPrec d . tintToInt32
instance Read TInt where
    readsPrec d s = map (\(a, r) -> (TInt a, r)) $ readsPrec d s

sizeOfTInt :: Int
sizeOfTInt = fromIntegral $ sizeOf (undefined :: TInt)

