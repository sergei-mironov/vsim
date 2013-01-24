
module Main where

import VSim.Runtime

elab :: Elab IO ()
elab = do
    integer <- alloc_unranged_type

    array <- alloc_array_type (alloc_range (pure 0) (pure 5)) integer

    clk <- alloc_signal "clk" integer (int 0)

    a1 <- alloc_signal "a1" array defval
    a2 <- alloc_signal_agg "a2" array [
          setidx (int 0) (pure clk)
        , setidx (int 1) (int 4)
        ]

    proc1 <- alloc_process "main" [] $ do
        breakpoint
        (pure clk) .<=. (next, assign ((pure clk) .+. (int 1)))
        -- (pure a1) .<=. (fs 2, aggregate [
        --     setidx (int 1) (assign $ (index (int 1) (pure a1)) .+. (int 1)),
        --     setidx (int 2) (assign $ int 3)])
        wait (fs 1)
        return ()
 
    return ()

main = do
   sim maxBound elab


