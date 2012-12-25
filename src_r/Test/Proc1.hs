module Main where

import VSim.Runtime
import VSim.Runtime.Ptr
import Control.Monad.Trans

add2 (In x :-: In y) = ((pure x) .+. (pure y))

fix :: Elab VProc ()
fix = return ()

-- fn2 :: PrimitiveT -> (PrimitiveT, Ptr Signal) -> Elab VProc (VProc ())
fn2 t a1 a2 = do
    l1 <- alloc_variable "l1" t (assign (pure a1))
    fix
    return $ do
        (pure a1) .<=. (next, assign $ (int 11))
        (index (int 0) (pure a2)) .<=. (next, assign $ (int 0))

elab :: Elab IO ()
elab = do
    t_int <- alloc_unranged_type
    t_0_5 <- alloc_ranged_type (int 0) (int 5)

    array <- alloc_array_type (pure 1) (pure 5) t_int

    aa1 <- alloc_signal "a1" array id

    clk <- alloc_signal "clk" t_int (assign (int 0))

    v1 <- alloc_variable "v1" t_int (assign (int 11))
    v2 <- alloc_variable "v2" t_int (assign (int 22))

    v3 <- alloc_variable "v3" t_int (associate t_0_5 . assign (int 22))

    -- fn1 <- alloc_function "fn1" (assosiate t_int)
    

    -- let fn mx = associate t_0_5 mx >>= \a -> do
    --     fix
    --     return $ do
    --         (pure a) .<=. (next, assign (int 11))


    -- fn1 <- alloc_function "fn1" $ \(a1',a2',a3') -> do
    --     -- signal a1'
    --     -- a1 <- alloc_variable "a1" t_int (assign (pure a1'))
    --     -- a2 <- associate t_int (pure a2')
    --     -- a3 <- associate t_int (pure a3') 
    --     return $ do
    --         return ()

    -- let fn1 x = alloc_function "fn1" $ fn x

    -- fn1 (pure v1)

    proc1 <- alloc_process "main" [] $ do
        -- report $ t_image (call (pure v1 :-: (int 1)) add2) t_int
        breakpoint

        call $ ((fn2 =<< (pure t_0_5)) =<< (pure clk)) =<< (pure aa1)

        return ()
 
    return ()

main = do
   sim maxBound elab

