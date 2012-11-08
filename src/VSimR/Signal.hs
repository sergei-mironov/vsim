{-# LANGUAGE FlexibleContexts #-}

module VSimR.Signal where

import Control.Monad.Error
import Data.Maybe

import VSimR.Time
import VSimR.Waveform as W
import VSimR.Ptr
import VSimR.Variable

data Signal' a = Signal' {
      wcurr :: Waveform
    , oldvalue :: Int
    , sconstr :: Constraint
    , proc :: [a]
    } deriving(Show)

chwave :: Waveform -> Signal' a -> Signal' a
chwave w s = s { wcurr = w }

new :: Waveform -> Constraint -> [a] -> Signal' a
new w c ps = Signal' w 0 c ps

withinW :: Constraint -> Waveform -> Bool
withinW c (Waveform cs) = and $ map (within c) . map cvalue $ cs

earliest :: Signal' a -> Signal' a -> Ordering
earliest s1 s2 = W.earliest (wcurr s1) (wcurr s2)

