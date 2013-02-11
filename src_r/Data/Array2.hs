{-# LANGUAGE FlexibleContexts #-}

-- | Yet another Array with business-logic
module Data.Array2 where

import Control.Monad
import Control.Monad.Trans

import Data.Range as Range
import Data.List as L
import Data.Array as Array
import Data.Array.IArray
import Data.IntMap as IntMap hiding ((\\))
import Text.Printf

data Array2 a =
      MapForm (IntMap.IntMap a)
    | ArrayForm (Array.Array Int a)
    deriving(Show)

empty :: Array2 a
empty = MapForm IntMap.empty

index :: (IArray Array a) => Int -> Array2 a -> Maybe a
index i a2@(MapForm l) = IntMap.lookup i l
index i a2@(ArrayForm a) = Just $ a Array.! i

-- FIXME: revert to add
update :: (IArray Array a) => Int -> a -> Array2 a -> Array2 a
update i e (MapForm l) = MapForm $ IntMap.insert i e l
update i e (ArrayForm a) = error "Array2.update: Updating array in Array form is forbidden"

scanRange a2@(MapForm l)
    | IntMap.null l = NullRangeT
    | otherwise = RangeT (fst $ findMin l) (fst $ findMax l)
scanRange a2@(ArrayForm a) = 
    let (l,u) = Array.bounds a in RangeT l u

toList :: (IArray Array a) => RangeT -> Array2 a -> [(Int, Maybe a)]
toList rg a2@(MapForm l) =
    Prelude.map (\(a,b) -> (a,Just b)) (IntMap.toList l) ++
    (((Range.toList rg) \\ (IntMap.keys l)) `zip` (repeat Nothing))
toList rg a2@(ArrayForm a) = error "Array2.toList: not implemented"

fromList :: (IArray Array a) => [(Int, a)] -> Array2 a
fromList ls = MapForm $ IntMap.fromList ls

toArrayForm :: (IArray Array a) => RangeT -> [(Int, a)] -> Array2 a
toArrayForm rg@(RangeT l u) ls = ArrayForm $ Array.array (l,u) ls
toArrayForm _ _  = error "Array2.toArrayForm: can't use infinite or null range"

