module Main where

import VSim.Runtime

elab :: Elab IO ()
elab = do

    integer <- alloc_unranged_type
    arr <- alloc_array_type (pure 0) (pure 9) integer

    sig1 <- alloc_signal "n" (\f -> f integer (pure (left integer)))

    sig2 <- map_signal "n" (\f -> f integer (pure sig1))

    arr1 <- alloc_signal "n" arr ()

    arr1 <- alloc_signal "n" arr [
              setidx (pure 0) (pure sig1)
            , setidx (pure 1) (pure sig1)
            , setidx_aggr [(pure 3), (pure 4)] [
                  asdasdasdasd
                , asdasdasdasd
                , asdasdasdasd
                ]
        ]
