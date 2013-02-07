module Main where

import Data.Generics
import System.IO
import System.Exit
import System.Environment
import Text.Show.Pretty as PP

import VSim.Data.Loc
import VSim.Data.Line
import VSim.VIR

main = do
    hSetBuffering stdout NoBuffering
    files <- getArgs
    ps <- parseFiles files
    putStrLn $ show_noloc ps

