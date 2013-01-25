{-# LANGUAGE RecursiveDo #-}

module Main where

import VSim.Runtime
import VSim.Runtime.Ptr
import Control.Monad.Trans


elab :: Elab IO ()
elab = mdo
    t_int <- alloc_unranged_type
    t_0_5 <- alloc_ranged_type (alloc_range (int 0) (int 5))

    array <- alloc_array_type (alloc_range (pure 0) (pure 5)) t_int

    arr1 <- alloc_signal "a1" array defval

    clk <- alloc_signal "clk" t_int (assign (int 0))

    v1 <- alloc_variable "v1" t_int (assign (int 11))
    v2 <- alloc_variable "v2" t_int (assign (int 22))

    proc1 <- alloc_process "main" [clk] $ do
        breakpoint
        call $ fn2 << (pure clk) << (pure arr1)
        return ()

    fn2 <- alloc_function (\a1' a2' -> do
        l1 <- alloc_variable "l1" t_0_5 (assign (pure a1'))
        a1 <- (pure a1')
        a2 <- (pure a2')
        return $ do
            report $ (pure "report string")
            (pure a1) .<=. (next, assign $ (pure a1) .+. (int 1))
            (index (int 0) (pure a2)) .<=. (next, (
                assign $ (index (int 0) (pure a2)) .+. (int 1)))
            ret ())

    return ()

main = do
   sim maxBound elab

