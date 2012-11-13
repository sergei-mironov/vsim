module Main where

import System.IO
import System.Exit
import System.Environment
import Text.Show.Pretty as PP

import VSim.VIR

main = do
    hSetBuffering stdout NoBuffering
    files <- getArgs
    ps <- parseFiles files
    putStrLn $ PP.ppShow ps

