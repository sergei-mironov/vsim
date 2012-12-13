
module Main where

import VSim.Runtime

elab :: Elab ()
elab = do
    integer <- alloc_unranged_type

    t_array <- alloc_array_type (pure 1) (pure 5) integer

    clk <- alloc_signal "clk" integer (assign (int 0))
    a1 <- alloc_signal "a1" t_array id

    a2 <- alloc_signal "a2" t_array (aggregate [setidx (pure 1) (int 1)])

    proc1 <- alloc_process "main" [] $ do
        breakpoint
        (index (pure 1) (pure a1)) .<=. (next, ((int 1) .+. (index (pure 1) (pure a1))))
        (pure clk) .<=. (next, (pure clk) .+. (int 1))
        (pure a1) .<=. (next, (pure a2))
        wait (us 1)
 
    return ()

main = do
   sim maxBound elab


