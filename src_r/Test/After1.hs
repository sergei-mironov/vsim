
module Main where

import VSim.Runtime

elab :: Elab IO ()
elab = do
    t_int <- alloc_unranged_type
    s <- alloc_signal "s1" t_int (assign (int 0))

    proc1 <- alloc_process "main" [] $ do
        (pure s)  .<<=. [
              (fs 1, assign (int 1))
            , (fs 2, assign (int 2))
            , (fs 3, assign (int 3))
            ]
        wait (ms 1000)

    proc2 <- alloc_process "main" [s] $ do
        breakpoint

    return ()

main = do
   sim maxBound elab


