
module Main where

import VSim.Runtime

elab :: Elab ()
elab = do
    t_int <- alloc_unranged_type
    t_0_5 <- alloc_ranged_type 0 5

    s1 <- alloc_signal "s1" 0 t_int
    clk <- alloc_signal "clk" 0 t_int
    v <- alloc_variable "v" 0 t_0_5

    proc1 <- alloc_process "main" [clk] $ do
        breakpoint
        s1  `assign` (fs 5, (val clk))
        clk `assign` (now, (add (int 1) (val clk)))
        report (str "muhaha")
        return ()
 
    return ()


main = do
   sim time_max elab

