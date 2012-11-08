module VSim.Data.Line where

data Line = Line {
      lineFilename :: FilePath
    , lineLine     :: Int
    , lineColumn   :: Int
    }
    deriving (Show,Eq, Ord)

showLine :: Line -> String
showLine l = lineFilename l ++ ":" ++ show (lineLine l) ++ ":" ++ show (lineColumn l) ++ ":"
