
module Main where

import VSim.Runtime

elab :: Elab IO ()
elab = do
    integer <- alloc_unranged_type

    array <- alloc_array_type (alloc_range (pure 0) (pure 5)) integer

    (bit, [e0, e1]) <- alloc_enum ["0", "1"]


    proc1 <- alloc_process "main" [] $ do
        breakpoint
        assert
        return ()
 
    return ()

main = do
   sim maxBound elab



