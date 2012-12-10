
module Main where

import VSim.Runtime

elab :: Elab ()
elab = do
    t_int <- alloc_unranged_type
    t_0_5 <- alloc_ranged_type 0 5

    (t_rec1, f1 :- f2 :- _) <- alloc_record_type (("f1", t_int) :- ("f2", t_int) :- ())

    clk <- alloc_signal "clk" (set (int 0)) t_int

    r1 <- alloc_signal "r1" (aggr [
            setfld f1 (int 11),
            setfld f2 (int 22)
            ]) t_rec1

    proc1 <- alloc_process "main" [clk] $ do
        breakpoint
        (pure clk) `assign` (next, ((int 1) .+. (pure clk)))
        (field f1 (pure r1)) `assign` (next, (int 33))
        report (str "muhaha")
        return ()
 
    return ()

main = do
   sim maxBound elab


