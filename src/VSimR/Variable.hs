module VSimR.Variable where

import Control.Monad.Error
import Text.Printf

import VSimR.Time

data Constraint = Constraint {
      lower :: Int
    , upper :: Int
    } deriving(Show)

ranged a b = Constraint a b

unranged = Constraint minBound maxBound

within :: Constraint -> Int -> Bool
within (Constraint l u) v = v >= l && v <= u

data Variable = Variable {
      vname :: String
    , vval :: Int
    , vconstr :: Constraint
    } deriving(Show)

assignV :: (Monad m) => Variable -> Int -> m Variable
assignV (Variable n v c) v'
    | within c v' = return $ Variable n v c
    | otherwise = error $ printf "variable %s constraint failed" n

