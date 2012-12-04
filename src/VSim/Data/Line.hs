{-# LANGUAGE DeriveDataTypeable #-}

module VSim.Data.Line where

import Data.Typeable
import Data.Generics

data Line = Line {
      lineFilename :: FilePath
    , lineLine     :: Int
    , lineColumn   :: Int
    } | LineUnknown
    deriving (Show, Eq, Ord, Data, Typeable)

showLine :: Line -> String
showLine LineUnknown = "<no line info>"
showLine l = lineFilename l ++ ":" ++ show (lineLine l) ++ ":" ++ show (lineColumn l) ++ ":"

