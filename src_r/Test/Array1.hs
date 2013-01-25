
module Main where

import VSim.Runtime

elab :: Elab IO ()
elab = do
    integer <- alloc_unranged_type

    array <- alloc_array_type (alloc_range (pure 0) (pure 5)) integer

    clk <- alloc_signal "clk" integer (assign (int 0))

    a1 <- alloc_signal "a2" array (aggregate [
          access (int 0) (assign (pure clk))
        , access (int 1) (assign (int 4))
        ])

    a2 <- alloc_signal "a1" array defval

    a3 <- alloc_signal "a2" array (assign (pure a1))

    proc1 <- alloc_process "main" [] $ do
        breakpoint
        (pure clk) .<=. (next, assign ((pure clk) .+. (int 1)))
        (pure a2) .<=. (next, assign (pure a1))
        (pure a1) .<=. (fs 2, aggregate [
              access (int 1) (assign ((index (int 1) (pure a1)) .+. (int 1)))
            , access (int 2) (assign (int 3))
            ])
        (index (int 0) (pure a1)) .<=. (next, assign (int 0))
        wait (fs 1)
        return ()
 
    return ()

main = do
   sim maxBound elab


