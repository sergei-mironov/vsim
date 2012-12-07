
module Main where

import VSim.Runtime

elab :: Elab ()
elab = do
    t_int <- alloc_unranged_type
    t_0_5 <- alloc_ranged_type 0 5

    s1 <- alloc_signal "s1" (set (int 0)) t_int
    clk <- alloc_signal "clk" (set (int 0)) t_int
    v <- alloc_variable "v" (set (int 0)) t_0_5

    proc1 <- alloc_process "main" [clk] $ do
        breakpoint
        (pure s1)  `assign` (fs 5, (pure clk))
        (pure clk) `assign` (next, ((int 1) .+. (pure clk)))
        report (str "muhaha")
        return ()
 
    return ()

main = do
   sim maxBound elab

