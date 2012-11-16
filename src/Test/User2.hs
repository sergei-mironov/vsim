{-# LANGUAGE FlexibleContexts #-}

module Main where

import Control.Monad.Trans

import VSimR

elab :: Elab ()
elab = do
    s1 <- alloc_signal "s1" (wconst 0) (ranged 0 5)
    clk <- alloc_signal "clk" (wconst 0) unranged

    proc1 <- alloc_process [clk] $ do
        breakpoint
        s1  `assign` (now, val clk)
        clk `assign` (fs 2, int 1 .+. val clk)
        return ()

    return ()

main = do
   sim time_max elab

