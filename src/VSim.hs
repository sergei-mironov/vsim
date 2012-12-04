{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
module Main where

import qualified Data.ByteString.Char8 as BS

import Language.Haskell.Syntax
import Language.Haskell.Pretty

import Data.Maybe
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
    mkName :: x -> HsName

instance AsIdent String where
    mkName s = HsIdent s

instance AsIdent Ident where
    mkName = mkName . BS.unpack

instance AsIdent (Ident, [Ident]) where
    mkName (_,x:_) = mkName x
    mkName _ = error "mkName (hierPath): strange hierPath"

instance (AsIdent a) => AsIdent (WithLoc a) where
    mkName (WithLoc _ a) = mkName a

-- instance AsIdent IRNameG where
--     mkName (INIdent p) = mkName p
--     mkName _ = error "mkName: INIdent only, please"

-- instance AsIdent IRName where
--     mkName (IRName ng _) = mkName ng

gen_ident :: (AsIdent x) => x -> HsExp
gen_ident x = HsVar $ UnQual $ mkName x

gen_pat :: (AsIdent x) => x -> HsPat
gen_pat x = HsPVar $ mkName x

class AsInt x where
    gen_int :: x -> HsExp

instance AsInt TInt where
    gen_int i = HsLit $ HsInt $ fromIntegral i
    
instance AsInt Int where
    gen_int i = HsLit $ HsInt $ fromIntegral i

instance AsInt Int128 where
    gen_int i = HsLit $ HsInt $ fromIntegral i
    
instance (AsInt a) => AsInt (WithLoc a) where
    gen_int (WithLoc _ i) = gen_int i

noLoc = SrcLoc "<unknown>" 0 0

unHierPath :: WLHierNameWPath -> String
unHierPath (WithLoc _ (_,(s:_))) = BS.unpack s
unHierPath p = error "unHierPath: unsupported " ++ (show p)

gen_return x = gen_function [] "return" [x]

gen_appl' :: (AsIdent n) => n -> [HsExp] -> HsExp
gen_appl' n [] = error "gen_appl': no args"
gen_appl' n [a] = HsApp (gen_ident n) a
gen_appl' n (a:as) = HsApp (gen_appl' n as) a

gen_appl :: (AsIdent n) => n -> [HsExp] -> HsExp
gen_appl n as = HsParen $ gen_appl' n (reverse as)

gen_function :: (AsIdent n) => String -> n -> [HsExp] -> HsStmt
gen_function [] n [] = HsQualifier (gen_ident n)
gen_function [] n as = HsQualifier (gen_appl' n (reverse as))
gen_function r n [] = HsGenerator noLoc (HsPVar $ HsIdent r) (gen_ident n)
gen_function r n as = HsGenerator noLoc (HsPVar $ HsIdent r) (gen_appl' n (reverse as))

gen_list es = HsList es

gen_pair es = HsTuple es

gen_str s = HsLit $ HsString s

gen_elab_expr :: IRExpr -> HsExp
gen_elab_expr (IEInt loc i) = gen_appl "int" [gen_int i]
gen_elab_expr _ = error "gen_elab_expr: int constants only, please"

gen_expr_unit = unit_con

gen_lambda i s = HsParen $ HsLambda noLoc [gen_pat i] (HsParen $ HsDo $ s)

gen_int_ident tn@(ITDName n)
    | mkName n == HsIdent "integer" = gen_ident "integer"
    | otherwise = error $ "gen_int_ident: integer type, please. (got: " ++ show tn ++ ")"

gen_elab :: [IRTop] -> [HsDecl]
gen_elab ts = [
      HsTypeSig noLoc [HsIdent "elab"] (HsQualType [] (
        HsTyApp (HsTyCon $ UnQual $ HsIdent "Elab") (HsTyCon $ Special $ HsUnitCon)))
    , HsFunBind [HsMatch noLoc (HsIdent "elab") [] (HsUnGuardedRhs body) []]
    ] where
      
    body = HsDo $ concat [
          [gen_function "integer" "alloc_unranged_type" []]
        , gen_elab_constants ts
        , gen_elab' ts
        , [gen_return unit_con] 
        ]

    -- move all th constants to the top
    gen_elab_constants [] = []
    gen_elab_constants ((IRTConstant c):ts) = (gen_alloc_constant c) ++ (gen_elab_constants ts)
    gen_elab_constants (t:ts) = gen_elab_constants ts

    gen_elab' [] = []
    gen_elab' ((IRTType t):ts) = (gen_alloc_type t) ++ (gen_elab' ts)
    gen_elab' ((IRTSignal s):ts) = (gen_alloc_signal s) ++ (gen_elab' ts)
    gen_elab' ((IRTProcess p):ts) = (gen_alloc_process p) ++ (gen_elab' ts)
    gen_elab' (t:ts) = gen_elab' ts

    gen_alloc_type (IRType p (ITDArray [c] _)) =
        let (a,b) = gen_array_constr c in [
          gen_function (unHierPath p) "alloc_array_type" [
              gen_elab_expr a, gen_elab_expr b
            , gen_ident "t_int"
            ]
        ]
    gen_alloc_type _ = []

    gen_array_constr (Constrained _ (IRARDConstrained loc tn (IRDRange loc2 a DirTo b))) = (a,b)
    gen_array_constr _ = error "gen_array_constr: simple integer 1-dim arrays, please"

    gen_alloc_signal (IRSignal p t (IOEJustExpr _ e)) = [
          gen_function (unHierPath p) "alloc_signal" [
              gen_str $ unHierPath p
            , gen_elab_expr e
            , gen_int_ident t
            ]
        ]
    gen_alloc_signal (IRSignal p (ITDName t) (IOENothing loc)) = [
          gen_function (unHierPath p) "alloc_signal" [
              gen_str $ unHierPath p
            , gen_appl "rnd" [gen_ident t]
            , gen_ident t
            ]
        ]
    gen_alloc_signal _ = error $ concat [
          "gen_alloc_signal: want default value expression for simple signal"
        , "gen_alloc_signal: or simple int array without default val"
        ]

    gen_alloc_constant (IRConstant p _ loc e) = [
          gen_function (unHierPath p) "alloc_constant" [
              gen_str $ unHierPath p
            , gen_elab_expr e
            ]
        ]

    gen_alloc_variable (IRVariable p t (IOEJustExpr _ e)) = [
          gen_function (unHierPath p) "alloc_variable" [
              gen_str $ unHierPath p
            , gen_elab_expr e
            , gen_int_ident t
            ]
        ]
    gen_alloc_variable (IRVariable p t (IOENothing _)) = [
          gen_function (unHierPath p) "alloc_variable" [
              gen_str $ unHierPath p
            , gen_int (0 :: Int)
            , gen_int_ident t
            ]
        ]

    gen_alloc_process (IRProcess p ns lets s) = [
          gen_function (unHierPath p) "alloc_process_let" [
              gen_str $ unHierPath p
            , gen_list $ map scan_sens ns
            , gen_lets lets (gen_process s)
            ]
        ]
        where
            scan_sens (INIdent hp) = gen_ident hp
            scan_sens _ = error "scan_sens: use idents, please"
            gen_lets ls s = HsParen $ HsDo $ (concat $ map gen_lets' ls) ++ [gen_return s]
            gen_lets' (ILDConstant c) = gen_alloc_constant c
            gen_lets' (ILDVariable v) = gen_alloc_variable v

    gen_process ss = HsParen $ HsDo $ gen_stmt ss where

        gen_stmt (ISSeq a b) = gen_stmt a ++ gen_stmt b
        gen_stmt (ISAssign _ n _ e) = [
              gen_function [] "vassign" [
                  gen_name_ident n
                , gen_expr e
                ]
            ]
        gen_stmt (ISSignalAssign _ n _ []) = error "gen_stmt: no afters"
        gen_stmt (ISSignalAssign _ n _ [IRAfter v t]) = [
              gen_function [] "assign" [
                  gen_name_ident n
                , gen_pair [maybe (gen_ident "next") (gen_expr) t, gen_expr v]
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
        gen_stmt (ISReport loc e1 e2) = [gen_function [] "report" [gen_expr e1]]
        gen_stmt (ISWait loc [] Nothing (Just e)) = [gen_function [] "wait" [gen_expr e]]
        gen_stmt (ISFor lbl loc i (ITDRangeDescr range) s) = gen_for range i s
        gen_stmt e = error $ "gen_stmt: unknown stmt: " ++ show e

        gen_for (IRDRange loc e1 dir e2) ei s = [
              gen_function [] "for" [
                  gen_pair [gen_expr e1, gen_ident "To", gen_expr e2]
                , gen_lambda ei (gen_stmt s) 
                ]
            ]

        gen_expr (IEInt loc i) = gen_appl "int" [gen_int i]
        gen_expr (IEString loc bs) = gen_appl "str" [gen_str $ BS.unpack bs]
        gen_expr (IEName loc n) = gen_name_ident n
        gen_expr (IEBinOp loc IPlus e1 e2) = gen_appl "add" [gen_expr e1, gen_expr e2]
        gen_expr (IERelOp loc IGreaterEqual _ e1 e2) =
            gen_appl "greater_eq" [gen_expr e1, gen_expr e2]
        gen_expr (IEPhysical val un) = gen_appl un [gen_int val]
        gen_expr e = error $ "gen_expr: unsupported expr " ++ show e


        gen_name_ident (IRName n _) = gen_name_ident' n
        gen_name_ident' (INIdent p) = gen_appl "pure" [gen_ident p]
        gen_name_ident' (INIndex _ p _ [(_,e)]) = gen_appl "index" [
            gen_name_ident' p, gen_expr e]


gen_import m = HsImportDecl noLoc (Module m) False Nothing Nothing

gen_main = (:[]) $ HsFunBind [HsMatch noLoc (HsIdent "main") [] (HsUnGuardedRhs body) []] where
    body = HsDo [gen_function [] "sim" [gen_ident "maxBound", gen_ident "elab" ]]

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

