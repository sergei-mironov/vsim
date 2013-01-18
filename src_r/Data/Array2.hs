-- | Yet another Array with business-logic
module Data.Array2 where

import Control.Monad
import Control.Monad.Trans

import Data.List as L
import Data.Array.IO
import Data.IntMap as IntMap
import Text.Printf

data Array2 a =
      MapForm String (IntMap.IntMap a)
    -- | VectorForm String (IOArray Int a)
    deriving(Show)

empty :: String -> Array2 a
empty s = MapForm s IntMap.empty

allocDef :: (MonadIO m) => String -> [Int] -> (String -> m a) -> m (Array2 a)
allocDef n ids me = do
    es <- forM ids $ \i -> me (printf "%s[%d]" n i) >>= \e -> return (i,e)
    return $ MapForm n $ IntMap.fromList es

writeArray :: (MonadIO m) => Array2 a -> Int -> (String -> m a) -> m (Array2 a)
writeArray a2@(MapForm n l) i me = do
    e <- me (printf "%s[%d]" n i)
    return (MapForm n $ IntMap.insert i e l)

readArrayDef :: (MonadIO m) => Array2 a -> Int -> (String -> m a) -> m (a, Array2 a)
readArrayDef a2@(MapForm n l) i me = do
    case IntMap.lookup i l of
        Just e -> return (e, a2)
        Nothing -> do
            e <- me (printf "%s[%d]" n i)
            return (e, MapForm n $ IntMap.insert i e l)

readArray :: (MonadIO m) => Array2 a -> Int -> m a
readArray a2@(MapForm n l) i = do
    case IntMap.lookup i l of
        Just e -> return e
        Nothing -> error "readArray: element does not exist"

allocIfNull :: (MonadIO m) => Array2 a -> Int -> (String -> m a) -> m (Array2 a)
allocIfNull a2 i ma = snd `liftM` readArrayDef a2 i ma

scanRange a2@(MapForm n l) = (fst $ findMin l, fst $ findMax l)

