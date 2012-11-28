module Main where

import Data.Generics
import System.IO
import System.Exit
import System.Environment
import Text.Show.Pretty as PP

import VSim.Data.Loc
import VSim.Data.Line
import VSim.VIR

-- | Clean all the location and line info
noloc :: IRTop -> IRTop
noloc = everywhere (mkT (const NoLoc)) . everywhere (mkT (const LineUnknown))

main = do
    hSetBuffering stdout NoBuffering
    files <- getArgs
    ps <- parseFiles files
    putStrLn $ PP.ppShow $ map noloc ps

