module Main where

import VSim.Runtime

add2 (In x :-: In y) = ((pure x) .+. (pure y))

elab :: Elab IO ()
elab = do
    t_int <- alloc_unranged_type
    t_0_5 <- alloc_ranged_type (int 0) (int 5)

    clk <- alloc_signal "clk" t_int (assign (int 0))

    v1 <- alloc_variable "v1" t_int (assign (int 11))
    v2 <- alloc_variable "v2" t_int (assign (int 22))

    -- fn1 <- alloc_function "fn1" $ \'a1 'a2 'a3 -> do
    --     a1 <- alloc_variable "a1" t_int (assign (pure 'a1))
    --     a2 <- alloc_variable "a2" t_int (assign (pure 'a2))
    --     a3 <- alloc_out n3 
    --     return $ (In a, InOut b, Out c) -> do
    --         return ()

    proc1 <- alloc_process "main" [] $ do
        -- report $ t_image (call (pure v1 :-: (int 1)) add2) t_int
        breakpoint
        return ()
 
    return ()

main = do
   sim maxBound elab

