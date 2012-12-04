module Main where

import VSim.Runtime

elab :: Elab ()
elab = do
    t_int <- alloc_unranged_type
    clk <- alloc_signal "clk" 0 t_int

    proc1 <- alloc_process_let "main" [clk] $ do
        v <- alloc_variable "v" 1 t_int
        return $ do
            breakpoint
            clk `assign` (next, ((val v) .+. (val clk)))
            report (str "muhaha")
            return ()
    return ()

main = do
   sim maxBound elab

