module Main where

import VSim.Runtime

elab :: Elab IO ()
elab = do
    t_int <- alloc_unranged_type
    clk <- alloc_signal "clk" t_int (assign (int 0))

    proc1 <- alloc_process_let "main" [clk] $ do
        v <- alloc_variable "v" t_int (assign (int 1))
        return $ do
            breakpoint
            (pure clk) .<=. (next, assign ((val v) .+. (val clk)))
            report (str "muhaha")
            return ()
    return ()

main = do
   sim maxBound elab

