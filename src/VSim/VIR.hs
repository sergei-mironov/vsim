-- | Vir-file lexer/parser.
-- VIR folder contains current version of parser used by Simulator
-- VIR2 folder containes experimental parser for future static analysis
module VSim.VIR 
    ( module VSim.VIR.AST
    , module VSim.VIR.Types
    , module VSim.VIR.Syntax
    , EnumElement(..)
    , unHierPath
    , find_arg_type
    ) where

import Data.Generics
import Data.List as List
import Data.ByteString.Char8 as BS

import VSim.VIR.AST
import VSim.VIR.Types
import VSim.VIR.Syntax
import VSim.VIR.Lexer

import VSim.Data.Loc
import VSim.Data.NamePath

unHierPath :: WLHierNameWPath -> String
unHierPath (WithLoc _ (_,ls)) = List.intercalate "_" (List.map BS.unpack ls)

-- | Searches for Type of function or procedure argument
find_arg_type :: WLHierNameWPath -> Int -> IRTop -> IRTypeDescr
find_arg_type name i top = extract $ check1 $ listify is_proc top where
    is_proc (IRProcedure pname _ _) = name == pname
    check1 [x] = x
    check1 [] = error $ "find_arg_type: no objects found for " ++ (show name)
    check1 xs = error $ "find_arg_type: more than 1 objects found: " ++ (show xs)
    extract (IRProcedure _ args _) = untype (args !! i)
    untype (IRArg _ t _ _) = t


