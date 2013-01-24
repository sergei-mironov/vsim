
module Main where

import VSim.Runtime

elab :: Elab IO ()
elab = do
    integer <- alloc_unranged_type

    array <- alloc_array_type (alloc_range (pure 0) (pure 5)) integer

    clk <- alloc_signal "clk" integer (assign (int 0))

    a1 <- alloc_signal "a1" array (aggregate [
          setall (assign (int 0))
        , setidx (pure 1) (assign (int 1))
        , setidx (pure 2) (assign (int 2))
        ])
    a2 <- alloc_signal "a2" array defval

    array' <- alloc_array_type (alloc_range (pure 1) (pure 5)) array
    aa1 <- alloc_signal "aa1" array' defval

    proc1 <- alloc_process "main" [] $ do
        breakpoint
        (pure clk) .<=. (next, assign ((pure clk) .+. (int 1)))
        (pure a1) .<=. (fs 2, aggregate [
            setidx (int 1) (assign $ (index (int 1) (pure a1)) .+. (int 1)),
            setidx (int 2) (assign $ int 3)])
        wait (fs 1)
        return ()
 
    return ()

main = do
   sim maxBound elab



