module Test.User1 where

import Control.Monad.Trans

import VSimR

data SS = SS {
      a_s1 :: Signal
    , a_s2 :: Signal
    , a_clk :: Signal
    , a_v :: Variable
    }



elab :: (MonadIO m, MonadState Memory m) => m (Memory, SS)
elab = do
    alloc_signal



