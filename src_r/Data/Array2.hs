-- | Yet another Array with business-logic
module Data.Array2 where

import Control.Monad
import Control.Monad.Trans

import Data.Range as Range
import Data.List as L
import Data.Array.IO
import Data.IntMap as IntMap hiding ((\\))
import Text.Printf

data Array2 a =
      MapForm (IntMap.IntMap a)
    deriving(Show)

empty :: Array2 a
empty = MapForm IntMap.empty

itemName a e = printf "%s[%d]" a e

allocDef :: (MonadIO m) => [Int] -> m a -> m (Array2 a)
allocDef ids me = do
    es <- forM ids $ \i -> me >>= \e -> return (i,e)
    return $ MapForm $ IntMap.fromList es

index :: Int -> Array2 a -> Maybe a
index i a2@(MapForm l) = IntMap.lookup i l

-- FIXME: revert to add
update :: Int -> a -> Array2 a -> Array2 a
update i a (MapForm l) = MapForm $ IntMap.insert i a l

scanRange a2@(MapForm l)
    | IntMap.null l = NullRangeT
    | otherwise = RangeT (fst $ findMin l) (fst $ findMax l)

toList :: RangeT -> Array2 a -> [(Int, Maybe a)]
toList rg a2@(MapForm l) =
    Prelude.map (\(a,b) -> (a,Just b)) (IntMap.toList l) ++
    (((Range.toList rg) \\ (IntMap.keys l)) `zip` (repeat Nothing))

fromList :: [(Int, a)] -> Array2 a
fromList ls = MapForm $ IntMap.fromList ls

