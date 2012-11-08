{-# LANGUAGE FlexibleContexts #-}

module VSimR.Signal where

import Control.Monad.Error
import Data.Maybe

import VSimR.Time
import VSimR.Waveform as W
import VSimR.Process
import VSimR.Ptr
import VSimR.Variable

data Signal = Signal {
      wcurr :: Waveform
    , wnext :: Waveform
    , sconstr :: Constraint
    , proc :: [Ptr Process]
    } deriving(Show)

new :: Waveform -> Constraint -> [Ptr Process] -> Signal
new w c ps = Signal w w c ps

withinW :: Constraint -> Waveform -> Bool
withinW c (Waveform cs) = and $ map (within c) . map cvalue $ cs

assignS :: (MonadError String m) => Signal -> Waveform -> m Signal
assignS (Signal wn wf c p) w'
    | withinW c w' = return $ Signal wn w' c p
    | otherwise = error "signal constraint failed"

earliest :: Signal -> Signal -> Ordering
earliest s1 s2 = W.earliest (wcurr s1) (wcurr s2)




