module Main where

import VSim.Runtime

elab :: Elab ()
elab = do
    t_int <- alloc_unranged_type
    t_0_5 <- alloc_ranged_type (int 0) (int 5)

    (t_rec1, f1 :- f2 :- _) <- alloc_record_type (("f1", t_int) :- ("f2", t_int) :- ())

    clk <- alloc_signal "clk" t_int (assign (int 0))

    r1 <- alloc_signal "r1" t_rec1 (aggregate [
            setfld f1 (assign (int 11)),
            setfld f2 (assign (int 22))
            ])

    proc1 <- alloc_process "main" [clk] $ do
        breakpoint
        (pure clk) .<=. (next, assign ((int 1) .+. (pure clk)))
        (field f1 (pure r1)) .<=. (next, assign (int 33))
        report (str "muhaha")
        return ()
 
    return ()

main = do
   sim maxBound elab



