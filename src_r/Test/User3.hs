
module Main where

import VSim.Runtime

elab :: Elab ()
elab = do
    t_int <- alloc_unranged_type
    t_0_5 <- alloc_ranged_type 0 5

    s1 <- alloc_signal "s1" 0 t_int
    clk <- alloc_signal "clk" 0 t_int

    proc1 <- alloc_process "main" [clk] $ do
        breakpoint
        s1  `assign` (next, (val clk))
        report (str "muhaha")
        return ()

    wait1 <- alloc_waitable "waitable" $ do
        clk `assign` (next, ((int 1) .+. (val clk)))
        wait (fs 5)
        clk `assign` (next, ((int 1) .+. (val clk)))
        wait (fs 10)
        
 
    return ()


main = do
   sim maxBound elab

