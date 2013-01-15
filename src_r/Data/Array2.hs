-- | Yet another Array with business-logic
module Data.Array2 where

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

writeArray :: (MonadIO m) => Array2 a -> Int -> (String -> m a) -> m (Array2 a)
writeArray a2@(MapForm n l) i me = do
    e <- me (printf "%s[%d]" n i)
    return (MapForm n $ IntMap.insert i e l)
-- writeArray a2@(VectorForm n v) i me = error "writeArray: vector form not implemented"

readArrayDef :: (MonadIO m) => Array2 a -> Int -> (String -> m a) -> m (a, Array2 a)
readArrayDef a2@(MapForm n l) i me = do
    case IntMap.lookup i l of
        Just e -> return (e, a2)
        Nothing -> do
            e <- me (printf "%s[%d]" n i)
            return (e, MapForm n $ IntMap.insert i e l)
-- readArrayDef a2@(VectorForm n v) i me = error "readArrayDef: vector form not implemented"
