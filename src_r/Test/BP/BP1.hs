import Control.Monad
import Control.Monad.BP
import Control.Monad.Trans
import System.IO

out :: (MonadIO m) => String -> m ()
out = liftIO . putStrLn

askBreak :: IO ()
askBreak = hGetChar stdin >>= filter where
    filter c | c `elem` "nN" = return ()
             | c == '\n' = askBreak
             | otherwise = fail "user-break"


str :: Int -> BP String String IO String
str i = do
    pause "about to convert"
    earlyBP (show i)
    out "error: reached unreachable"
    return "error"

prnt :: Int -> BP x String IO ()
prnt i = catchEarly (str i) >>= \s -> out ("prnt: " ++ s) 

gr :: Int -> Int -> BP Int String IO Int
gr a b = do
    pause $ "show a = " ++ show a
    pause $ "show b = " ++ show b
    when (a > b) $ do
        prnt a
        prnt b
        pause $ "(a > b) ==> 1"
        earlyBP 1
        out "Should never be reached"
    pause $ "(a <= b) ==> 0"
    return 0

processBP bp = do
    res <- runBP bp
    case res of
        Left ([],k) -> out "empty error, exiting" >> return Nothing
        Left (e,k) -> do
            out e
            -- askBreak
            processBP k
        Right x -> return (Just x)

main = do
    res <- processBP (catchEarly $ gr 1 0)
    out $ show res

