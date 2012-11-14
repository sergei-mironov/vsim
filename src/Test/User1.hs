{-# LANGUAGE FlexibleContexts #-}

module Main where

import Control.Monad.Trans

import VSimR

elab :: Elab ()
elab = do
    a_s1 <- alloc_signal (wconst 0) (ranged 0 10)
    a_s2 <- alloc_signal (wconst 0) (unranged)
    a_clk <- alloc_signal (wconst 0) (unranged)
    a_v <- alloc_variable 0 unranged

    proc1 <- alloc_process $ do
        assign a_s1 (wconst 0)
        return []

    return ()


main = do
   sim time_max elab

