module VSim where

import qualified Data.ByteString.Char8 as BS

import Language.Haskell.Syntax
import Language.Haskell.Pretty

import System.IO
import System.Exit
import System.Environment
import Text.Show.Pretty as PP

import VSim.Data.Loc
import VSim.Data.TInt
import VSim.VIR

noLoc = SrcLoc "<unknown>" 0 0

-- | Use short name for now
unHierPath :: WLHierNameWPath -> String
unHierPath (WithLoc _ (_,(s:_))) = BS.unpack s

gen_return = HsApp (HsCon $ UnQual $ HsIdent "return") (unit_con)

gen_function r n [] =
    HsGenerator noLoc (HsPVar $ HsIdent r) (HsVar $ UnQual $ HsIdent n)
gen_function r n (a:as) =
    HsGenerator noLoc (HsPVar $ HsIdent r) (gen_function' n (reverse (a:as)))
    where
        gen_function' n [] = error "gen_function: no args"
        gen_function' n [a] = HsApp (HsVar $ UnQual $ HsIdent n) a
        gen_function' n (a:as) = HsApp (gen_function' n as) a

gen_int i = HsLit $ HsInt i

gen_ident s = HsVar $ UnQual $ HsIdent s

gen_str s = HsLit $ HsString s

gen_elab_expr :: IRExpr -> HsExp
gen_elab_expr (IEInt loc (TInt i)) = gen_int $ fromIntegral i
gen_elab_expr _ = error "I support int constants only"

gen_elab :: [IRTop] -> HsDecl
gen_elab ts = HsFunBind [HsMatch noLoc (HsIdent "elab") [] (HsUnGuardedRhs body) []] where
    body = HsDo (static ++ gen_elab' ts)

    static = [
          (gen_function "t_int" "alloc_unranged_type" [])
        ]
    
    gen_elab' [] = []
    gen_elab' ((IRTSignal s):ts) = ((gen_alloc_signal s) ++ (gen_elab' ts))
    gen_elab' (t:ts) = gen_elab' ts

    gen_alloc_signal (IRSignal p _ (IOEJustExpr _ e)) = [
          (gen_function (unHierPath p) "alloc_signal" [
              gen_str $ unHierPath p
            , gen_elab_expr e
            , gen_ident $ "t_int"
            ])
        ]

gen_import m = HsImportDecl noLoc (Module m) False Nothing Nothing

gen_module :: [IRTop] -> HsModule
gen_module ts = HsModule noLoc (Module "Main") Nothing imports body where
    imports = [
         gen_import "VSim.Runtime"
       ]
    body = [
         gen_elab ts
    -- , gen_main
       ]

prettyPrintM tops = putStrLn $ prettyPrint $ gen_module tops

vsim :: [FilePath] -> IO ()
vsim files = do
    ps <- parseFiles files
    prettyPrintM ps

main = do
    getArgs >>= vsim

