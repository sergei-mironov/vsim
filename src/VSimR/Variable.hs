{-# LANGUAGE FlexibleInstances #-}
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

class Constrained x where
    within :: x -> Bool

instance Constrained (Int, Constraint) where
    within (v,(Constraint l u)) = v >= l && v <= u

data Variable = Variable {
      vname :: String
    , vval :: Int
    , vconstr :: Constraint
    } deriving(Show)

instance Constrained Variable where
    within v = within (vval v, vconstr v)

