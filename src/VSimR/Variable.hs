{-# LANGUAGE FlexibleContexts #-}

module VSimR.Variable where

import Control.Monad.Error

import VSimR.Time

data Constraint = Constraint {
      lower :: Int
    , upper :: Int
    } deriving(Show)

data Variable = Variable {
      vval :: Int
    , vconstr :: Constraint
    } deriving(Show)

within :: Constraint -> Int -> Bool
within (Constraint l u) v = v >= l && v <= u

assignV :: (MonadError String m) => Variable -> Int -> m Variable
assignV (Variable v c) v'
    | within c v' = return $ Variable v c
    | otherwise = error "variable constraint failed"

