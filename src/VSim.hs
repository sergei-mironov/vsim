module VSim where

import Language.Haskell.Syntax
import Language.Haskell.Pretty

import System.IO
import System.Exit
import System.Environment
import Text.Show.Pretty as PP

import VSim.VIR

noLoc = SrcLoc "<unknown>" 0 0

gen_return = HsApp (HsCon $ UnQual $ HsIdent "return") (unit_con)

gen_elab types signals = HsFunBind [elab] where
    elab = HsMatch noLoc (HsIdent "elab") [] body []
    body = HsUnGuardedRhs $ HsDo [
          HsQualifier $ gen_return
        , HsQualifier $ gen_return
        ]


gen_import m = HsImportDecl noLoc (Module m) False Nothing Nothing

gen_module :: [HsDecl] -> HsModule
gen_module decls = HsModule noLoc (Module "Main") Nothing imports decls
    where
        imports = [gen_import "VSim.Runtime"]

prettyPrintM = do
    let s = prettyPrint $ gen_module [gen_elab [] []]  
    putStrLn s


vsim :: [FilePath] -> IO ()
vsim files = do
    ps <- parseFiles files
    putStrLn $ PP.ppShow ps


main = do
    getArgs >>= vsim
