module Main where

import VSim.Runtime

elab :: Elab ()
elab = do
    t_int <- alloc_unranged_type
    clk <- alloc_signal "clk" t_int id

    proc1 <- alloc_process "main" [clk] $ do
                breakpoint
                for (int 3, To, int 6) $ \i -> do
                    (pure clk) .<=. (next, assign (pure i))
                    report (str $ "val " ++ (show i))
                return ()
    return ()

main = do
   sim maxBound elab


