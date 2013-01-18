module Main where

import VSim.Runtime

elab :: Elab IO ()
elab = do
    t_int <- alloc_unranged_type
    clk <- alloc_signal "clk" t_int defval

    proc1 <- alloc_process "main" [clk] $ do
                breakpoint
                for (int 3, To, int 6) $ \i -> do
                    report (str $ "val " ++ (show i))
                (pure clk) .<=. (next, assign $ (int 1) .+. (pure clk))
                return ()
    return ()

main = do
   sim maxBound elab


