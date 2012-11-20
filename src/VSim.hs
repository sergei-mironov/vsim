{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
module Main where

import qualified Data.ByteString.Char8 as BS

import Language.Haskell.Syntax
import Language.Haskell.Pretty

import System.IO
import System.Exit
import System.Environment
import Text.Show.Pretty as PP

import VSim.Data.Loc
import VSim.Data.TInt
import VSim.Data.Int128
import VSim.Data.NamePath
import VSim.VIR

class AsIdent x where
    gen_ident :: x -> HsExp

instance AsIdent String where
    gen_ident s = HsVar $ UnQual $ HsIdent s

instance AsIdent Ident where
    gen_ident = gen_ident . BS.unpack

instance AsIdent (Ident, [Ident]) where
    gen_ident (_,x:_) = gen_ident x
    gen_ident _ = error "gen_ident (hierPath): strange hierPath"

instance AsIdent a => AsIdent (WithLoc a) where
    gen_ident (WithLoc _ a) = gen_ident a

instance AsIdent IRNameG where
    gen_ident (INIdent p) = gen_ident p
    gen_ident _ = error "gen_ident: INIdent only, please"

instance AsIdent IRName where
    gen_ident (IRName ng _) = gen_ident ng

class AsInt x where
    gen_int :: x -> HsExp

instance AsInt TInt where
    gen_int i = HsLit $ HsInt $ fromIntegral i
    
instance AsInt Int128 where
    gen_int i = HsLit $ HsInt $ fromIntegral i
    
instance (AsInt a) => AsInt (WithLoc a) where
    gen_int (WithLoc _ i) = gen_int i

noLoc = SrcLoc "<unknown>" 0 0

-- Use short name for now
unHierPath :: WLHierNameWPath -> String
unHierPath (WithLoc _ (_,(s:_))) = BS.unpack s

gen_return = HsApp (HsCon $ UnQual $ HsIdent "return") (unit_con)

gen_appl' :: (AsIdent n) => n -> [HsExp] -> HsExp
gen_appl' n [] = error "gen_appl': no args"
gen_appl' n [a] = HsApp (gen_ident n) a
gen_appl' n (a:as) = HsApp (gen_appl' n as) a

gen_appl :: (AsIdent n) => n -> [HsExp] -> HsExp
gen_appl n as = HsParen $ gen_appl' n (reverse as)

gen_function [] n [] = HsQualifier (HsVar $ UnQual $ HsIdent n)
gen_function [] n as = HsQualifier (gen_appl' n (reverse as))
gen_function r n [] = HsGenerator noLoc (HsPVar $ HsIdent r) (HsVar $ UnQual $ HsIdent n)
gen_function r n as = HsGenerator noLoc (HsPVar $ HsIdent r) (gen_appl' n (reverse as))

gen_list es = HsList es

gen_pair es = HsTuple es

gen_str s = HsLit $ HsString s

gen_elab_expr :: IRExpr -> HsExp
gen_elab_expr (IEInt loc i) = gen_int i
gen_elab_expr _ = error "I support int constants only"

gen_expr_unit = unit_con

gen_elab :: [IRTop] -> [HsDecl]
gen_elab ts = [
      HsTypeSig noLoc [HsIdent "elab"] (HsQualType [] (
        HsTyApp (HsTyCon $ UnQual $ HsIdent "Elab") (HsTyCon $ Special $ HsUnitCon)))
    , HsFunBind [HsMatch noLoc (HsIdent "elab") [] (HsUnGuardedRhs body) []]
    ] where
      
    body = HsDo $ concat [
          [gen_function "t_int" "alloc_unranged_type" []]
        , gen_elab_constants ts
        , gen_elab' ts
        , [gen_function [] "return" [unit_con]] 
        ]

    gen_elab_constants [] = []
    gen_elab_constants ((IRTConstant c):ts) = (gen_alloc_constant c) ++ (gen_elab_constants ts)
    gen_elab_constants (t:ts) = gen_elab_constants ts

    gen_elab' [] = []
    gen_elab' ((IRTSignal s):ts) = (gen_alloc_signal s) ++ (gen_elab' ts)
    gen_elab' ((IRTProcess p):ts) = (gen_alloc_process p) ++ (gen_elab' ts)
    gen_elab' (t:ts) = gen_elab' ts

    gen_alloc_signal (IRSignal p _ (IOEJustExpr _ e)) = [
          gen_function (unHierPath p) "alloc_signal" [
              gen_str $ unHierPath p
            , gen_elab_expr e
            , gen_ident "t_int"
            ]
        ]
    gen_alloc_signal (IRSignal p _ _) = error "gen_alloc_signal: want default value expression"

    gen_alloc_constant (IRConstant p _ loc e) = [
          gen_function (unHierPath p) "alloc_constant" [
              gen_str $ unHierPath p
            , gen_elab_expr e
            ]
        ]

    gen_alloc_process (IRProcess p ns [] s) = [
          gen_function (unHierPath p) "alloc_process" [
              gen_str $ unHierPath p
            , gen_list $ map scan_sens ns
            , gen_process $ s
            ]
        ]
        where
            scan_sens (INIdent hp) = gen_ident hp
            scan_sens _ = error "scan_sens: only idents are supported"

    gen_alloc_process _ = error "gen_alloc_process: no let-decs, please"

    gen_process ss = HsParen $ HsDo $ gen_stmt ss where

        gen_stmt (ISSeq a b) = gen_stmt a ++ gen_stmt b
        gen_stmt (ISSignalAssign _ n _ []) = [
              gen_function [] "assign" [
                  gen_ident n
                , gen_ident "now"
                ]
            ]
        gen_stmt (ISSignalAssign _ n _ [IRAfter v t]) = [
              gen_function [] "assign" [
                  gen_ident n
                , gen_pair [gen_expr t, gen_expr v]
                ]
            ]
        gen_stmt (ISNop loc) = [gen_function [] "return" [unit_con]]
        gen_stmt (ISNil) = [gen_function [] "return" [unit_con]]
        gen_stmt (ISIf loc e s1 s2) = [
              gen_function [] "iF" [
                  gen_expr e
                , HsParen $ HsDo $ gen_stmt s1
                , HsParen $ HsDo $ gen_stmt s2
                ]
            ]
        gen_stmt (ISAssert loc e1 e2 e3) = [gen_function [] "assert" []]
        gen_stmt e = error $ "gen_expr: unknown expr: " ++ show e

        gen_expr (IEInt loc i) = gen_appl "int" [gen_int i]
        gen_expr (IEName loc n) = gen_appl "val" [gen_ident n]
        gen_expr (IEBinOp loc IPlus e1 e2) = gen_appl "add" [gen_expr e1, gen_expr e2]
        gen_expr (IERelOp loc IGreaterEqual _ e1 e2) =
            gen_appl "greater_eq" [gen_expr e1, gen_expr e2]
        gen_expr (IEPhysical val un) = gen_appl un [gen_int val]
        gen_expr e = error $ "gen_expr: unsupported expr " ++ show e

gen_import m = HsImportDecl noLoc (Module m) False Nothing Nothing

gen_main = (:[]) $ HsFunBind [HsMatch noLoc (HsIdent "main") [] (HsUnGuardedRhs body) []] where
    body = HsDo [gen_function [] "sim" [gen_ident "time_max", gen_ident "elab" ]]

gen_module :: [IRTop] -> HsModule
gen_module ts = HsModule noLoc (Module "Main") Nothing imports body where
    imports = [
          gen_import "VSim.Runtime"
        ]
    body = concat [
          gen_elab ts
        , gen_main
        ]

prettyPrintM tops = putStrLn $ prettyPrint $ gen_module tops

vsim :: [FilePath] -> IO ()
vsim files = do
    ps <- parseFiles files
    prettyPrintM ps

main = do
    getArgs >>= vsim

