module Main where

import VSim.Runtime
import VSim.Runtime.Ptr
import Control.Monad.Trans

elab :: Elab IO ()
elab = do
    t_int <- alloc_unranged_type
    t_0_5 <- alloc_ranged_type (int 0) (int 5)

    array <- alloc_array_type (alloc_range (pure 1) (pure 5)) t_int

    aa1 <- alloc_signal "a1" array id

    clk <- alloc_signal "clk" t_int (assign (int 0))

    v1 <- alloc_variable "v1" t_int (assign (int 11))
    v2 <- alloc_variable "v2" t_int (assign (int 22))

    -- FIXME: why not working?
    -- v3 <- alloc_variable "v3" t_int (cast t_0_5 . assign (int 22))

    let fn2 a1' a2' = do
        l1 <- alloc_variable "l1" t_0_5 (assign (pure a1'))
        a1 <- (pure a1')
        a2 <- (pure a2')
        return $ do
            report $ (pure "1111111")
            (pure a1) .<=. (next, assign $ (pure a1) .+. (int 1))
            (index (int 1) (pure a2)) .<=. (next, assign $ (int 0))
            report $ (pure $ show l1)

    proc1 <- alloc_process "main" [clk] $ do
        breakpoint

        call $ fn2 << (pure clk) << (pure aa1)

        return ()
 
    return ()

main = do
   sim maxBound elab

