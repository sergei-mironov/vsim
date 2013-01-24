
module Main where

import VSim.Runtime

stuff x = return ()

elab :: Elab IO ()
elab = do
    t_int <- alloc_unranged_type
    t_0_5 <- alloc_ranged_type (alloc_range (int 0) (int 5))

    s1 <- alloc_signal "s1" t_int defval
    s2 <- alloc_signal "s2" t_int defval
    clk <- alloc_signal "clk" t_int (set $ int 33)
    v <- alloc_variable "v" t_0_5 (set $ int 0)
    v2 <- alloc_variable "v2" t_0_5 (set $ (pure v) .+. (int 0))

    proc1 <- alloc_process "main" [clk] $ do
        breakpoint
        (pure s1)  .<=. (fs 5, set (pure clk))
        (pure clk) .<=. (next, set $ ((int 1) .+. (pure clk)))
        report (str "muhaha")
        return ()
 
    return ()

main = do
   sim maxBound elab

