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
    -- | VectorForm String (IOArray Int a)
    deriving(Show)

empty :: Array2 a
empty = MapForm IntMap.empty

itemName a e = printf "%s[%d]" a e

allocDef :: (MonadIO m) => [Int] -> m a -> m (Array2 a)
allocDef ids me = do
    es <- forM ids $ \i -> me >>= \e -> return (i,e)
    return $ MapForm $ IntMap.fromList es

-- writeArray :: (MonadIO m) => Int -> (m a) -> Array2 a -> m (Array2 a)
-- writeArray i me a2@(MapForm l) = do
--     e <- me
--     return (MapForm $ IntMap.insert i e l)

-- readArrayDef :: (MonadIO m) => Int -> (m a) -> Array2 a -> m (a, Array2 a)
-- readArrayDef i me a2@(MapForm l) = do
--     case IntMap.lookup i l of
--         Just e -> return (e, a2)
--         Nothing -> do
--             e <- me
--             return (e, MapForm $ IntMap.insert i e l)

index :: Int -> Array2 a -> Maybe a
index i a2@(MapForm l) = IntMap.lookup i l

-- FIXME: revert to add
update :: Int -> a -> Array2 a -> Array2 a
update i a (MapForm l) = MapForm $ IntMap.insert i a l

-- allocItem :: Int -> a -> Array2 a -> Maybe (Array2 a)
-- allocItem i e a2@(MapForm l) =
--     case IntMap.lookup i l of
--         Just _ -> Nothing
--         Nothing -> (Just $ MapForm $ IntMap.insert i e l)

-- allocIfNull :: (MonadIO m) => Int -> m a -> Array2 a -> m (Array2 a)
-- allocIfNull i ma a2 = snd `liftM` readArrayDef i ma a2

scanRange a2@(MapForm l)
    | IntMap.null l = NullRangeT
    | otherwise = RangeT (fst $ findMin l) (fst $ findMax l)

-- allocRangeM :: (Monad m) => (Int -> m a) -> RangeT -> Array2 a -> m (Array2 a)
-- allocRangeM ma UnconstrT a2@(MapForm l) =
--     fail "allocRangeM: attempt to allocate unconstrained array"
-- allocRangeM ma rg a2@(MapForm l) = do
--     let foldM' a b f = foldM f a b
--     MapForm `liftM` foldM' l ((Range.toList rg) \\ (IntMap.keys l)) (\l i -> do
--         ma i >>= \a -> return $ IntMap.insert i a l)

toList :: RangeT -> Array2 a -> [(Int, Maybe a)]
toList rg a2@(MapForm l) =
    Prelude.map (\(a,b) -> (a,Just b)) (IntMap.toList l) ++
    (((Range.toList rg) \\ (IntMap.keys l)) `zip` (repeat Nothing))

fromList :: [(Int, a)] -> Array2 a
fromList ls = MapForm $ IntMap.fromList ls
