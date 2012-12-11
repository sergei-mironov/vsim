
module Main where

import VSim.Runtime

elab :: Elab ()
elab = do
    integer <- alloc_unranged_type

    t_array <- alloc_array_type (pure 1) (pure 5) integer

    a1 <- alloc_signal "a1" t_array return
    a2 <- alloc_signal "a2" t_array return

    proc1 <- alloc_process "main" [] $ do
        breakpoint
        (index (pure 1) (pure a1)) `assign` (next, ((int 1) .+. (index (pure 1) (pure a1))))
        wait (us 1)
 
    return ()

main = do
   sim maxBound elab


