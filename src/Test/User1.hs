{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RecordWildCards #-}

module Test.User1 where

import Control.Monad.Trans

import VSimR

data SS = SS {
      a_s1 :: Ptr Signal
    , a_s2 :: Ptr Signal
    , a_clk :: Ptr Signal
    , a_v :: Ptr Variable
    , proc1 :: Ptr Process
    }

elab :: Elab SS
elab = do
    a_s1 <- alloc_signal (wconst 0) (ranged 0 10)
    a_s2 <- alloc_signal (wconst 0) (unranged)
    a_clk <- alloc_signal (wconst 0) (unranged)
    a_v <- alloc_variable 0 unranged
    proc1 <- alloc_process proc1_body;
    return $ SS {..}

proc1_body :: (MonadSim s m) => ProcessHandler s m
proc1_body = do
    return []

