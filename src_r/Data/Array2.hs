-- | Yet another Array with business-logic
module Data.Array2 where

import Control.Monad
import Control.Monad.Trans

import Data.List as L
import Data.Array.IO
import Data.IntMap as IntMap
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

writeArray :: (MonadIO m) => Int -> (m a) -> Array2 a -> m (Array2 a)
writeArray i me a2@(MapForm l) = do
    e <- me
    return (MapForm $ IntMap.insert i e l)

readArrayDef :: (MonadIO m) => Int -> (m a) -> Array2 a -> m (a, Array2 a)
readArrayDef i me a2@(MapForm l) = do
    case IntMap.lookup i l of
        Just e -> return (e, a2)
        Nothing -> do
            e <- me
            return (e, MapForm $ IntMap.insert i e l)

readArray :: Int -> Array2 a -> Maybe a
readArray i a2@(MapForm l) = IntMap.lookup i l


allocItem :: Int -> a -> Array2 a -> Maybe (Array2 a)
allocItem i e a2@(MapForm l) =
    case IntMap.lookup i l of
        Just _ -> Nothing
        Nothing -> (Just $ MapForm $ IntMap.insert i e l)

allocIfNull :: (MonadIO m) => Int -> m a -> Array2 a -> m (Array2 a)
allocIfNull i ma a2 = snd `liftM` readArrayDef i ma a2

scanRange a2@(MapForm l) = (fst $ findMin l, fst $ findMax l)

