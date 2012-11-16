{-# LANGUAGE FlexibleInstances #-}
module VSim.Runtime.Constraint where

data Constraint = Constraint {
      lower :: Int
    , upper :: Int
    } deriving(Show)

ranged a b = Constraint a b

unranged = Constraint minBound maxBound

class Constrained x where
    within :: x -> Bool

instance Constrained (Int, Constraint) where
    within (v,(Constraint l u)) = v >= l && v <= u

