{-# LANGUAGE TypeOperators #-}

module Data.NestedTuple where

-- | Another way to write a nested tuple. (a,(b,(c,d))) can now be written as
-- (a :-: b :-: c :-: d)
data a :-: b = a :-: b
    deriving (Eq, Ord, Show)

infixr 5 :-:

