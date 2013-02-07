{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
module Main where

import qualified Data.ByteString.Char8 as BS

import Language.Haskell.Exts.Syntax as HS
import Language.Haskell.Exts.Pretty as HS

import Data.Char
import Data.Maybe
import Data.List as List
import System.IO
import System.Exit
import System.Environment
import Text.Show.Pretty as PP
import Text.Printf

import VSim.Data.Loc
import VSim.Data.TInt
import VSim.Data.Int128
import VSim.Data.NamePath
import VSim.VIR

perror x = error . printf (x ++ "\n")

class AsIdent x where
    mkName :: x -> HS.Name

instance AsIdent String where
    mkName s = HS.Ident s

instance AsIdent Ident where
    mkName = mkName . BS.unpack

instance (AsIdent a) => AsIdent (WithLoc a) where
    mkName (WithLoc _ a) = mkName a

gen_ident :: (AsIdent x) => x -> HS.Exp
gen_ident x = HS.Var $ UnQual $ mkName x

gen_pat :: (AsIdent x) => x -> HS.Pat
gen_pat x = HS.PVar $ mkName x

mangle' :: (AsIdent x) => x -> String
mangle' x = let HS.Ident i = mkName x in (i++"'")

paren_int i exp
    | i < 0 = HS.Paren exp
    | otherwise = exp

class AsInt x where
    gen_int :: x -> HS.Exp

instance AsInt TInt where
    gen_int i = paren_int i $ HS.Lit $ HS.Int $ fromIntegral i
    
instance AsInt Int where
    gen_int i = paren_int i $ HS.Lit $ HS.Int $ fromIntegral i

instance AsInt Int128 where
    gen_int i = paren_int i $ HS.Lit $ HS.Int $ fromIntegral i
    
instance (AsInt a) => AsInt (WithLoc a) where
    gen_int (WithLoc _ i) = gen_int i

noLoc = SrcLoc "<unknown>" 0 0

shortName :: WLHierNameWPath -> String
shortName (WithLoc _ (_,(n:_))) = BS.unpack n
-- unHierPath p = error "unHierPath: unsupported " ++ (show p)

gen_appl' :: (AsIdent n) => n -> [HS.Exp] -> HS.Exp
gen_appl' n [] = error "gen_appl': no args"
gen_appl' n [a] = HS.App (gen_ident n) a
gen_appl' n (a:as) = HS.App (gen_appl' n as) a

gen_appl :: (AsIdent n) => n -> [HS.Exp] -> HS.Exp
gen_appl n as = HS.Paren $ gen_appl' n (reverse as)

appl_alloc_constant t e = gen_appl "alloc_constant" [ t , e ]

gen_op :: String -> HS.Exp -> HS.Exp -> HS.Exp
gen_op n e1 e2 = HS.Paren $ HS.InfixApp e1 qn e2 where
    qn = HS.QVarOp $ UnQual $ HS.Symbol n

gen_op_chain op es = goc $ reverse es where
    goc (e1:e2:[]) = gen_op op e2 e1
    goc (e1:es)    = gen_op op (goc es) e1

-- | Generate monadic statement like `n args'
gen_function_ :: (AsIdent n) => n -> [HS.Exp] -> HS.Stmt
gen_function_ n [] = HS.Qualifier (gen_ident n)
gen_function_ n as = HS.Qualifier (gen_appl' n (reverse as))

-- | Generate monadic statement like `x <- n args'
gen_function_ret :: (AsIdent n, AsIdent p) => p -> n -> [HS.Exp] -> HS.Stmt
gen_function_ret r n [] = HS.Generator noLoc (gen_pat r) (gen_ident n)
gen_function_ret r n as = HS.Generator noLoc (gen_pat r) (gen_appl' n (reverse as))

-- | Generate monadic statement like `x <- n args'
gen_function_ret' r as = HS.Generator noLoc (gen_pat r) as

-- | Generate monadic statement like `x <- n args'
gen_function :: (AsIdent n) => HS.Pat -> n -> [HS.Exp] -> HS.Stmt
gen_function pat n [] = HS.Generator noLoc pat (gen_ident n)
gen_function pat n as = HS.Generator noLoc pat (gen_appl' n (reverse as))

-- Return wrappers
gen_return p x = gen_function_ret p "return" [x]
gen_return_ x = gen_function_ "return" [x]

gen_list es = HS.List es

gen_pair es = HS.Tuple es

gen_pat_pair es = HS.PTuple es

gen_pat_list es = HS.PList es

gen_str s = HS.Lit $ HS.String $ unI $ mkName s where
    unI (HS.Ident x) = x
    unI (HS.Symbol x) = x

gen_expr_unit = unit_con

gen_lambda i s = HS.Paren $ HS.Lambda noLoc [gen_pat i] (HS.Paren $ HS.Do $ s)

gen_assign x = gen_appl "assign" x

gen_assign_or_aggregate f e = build (expr_to_aggr e) where
    expr_to_aggr (IEAggregate _ ass) = Just ass
    expr_to_aggr (IEName _ (IRName (INAggregate _ ass _) _)) = Just ass
    expr_to_aggr _ = Nothing

    build (Just ass) = gen_appl "aggregate" [
        gen_list $ others ass ++ aggr ass] where
            others (IEAOthers loc e:as) =
                (gen_appl "setall" [gen_assign_or_aggregate f e]) : others as
            others (_:as) = others as
            others [] = []

            aggr (IEAExprIndex loc i e:as) = (gen_appl "setidx" [f i, gaa f e]) : (aggr as)
            aggr (IEAOthers _ _:as) = aggr as
            aggr [] = []
            aggr a = perror "gen_assign_or_aggregate: index or others, please (got %s)" (show a)

            gaa = gen_assign_or_aggregate

    build Nothing = gen_assign [f e]

gen_defval = gen_ident "defval"

gen_elab :: [IRTop] -> [HS.Decl]
gen_elab ts = [
      HS.TypeSig noLoc [HS.Ident "elab"] ((
        HS.TyApp (HS.TyApp (HS.TyCon $ UnQual $ HS.Ident "Elab")
            (HS.TyCon $ UnQual $ HS.Ident "IO"))
                (HS.TyCon $ Special $ HS.UnitCon)))

    , HS.FunBind [HS.Match noLoc (HS.Ident "elab") [] Nothing (HS.UnGuardedRhs body) (BDecls [])]
    ] where

    name_of_integer = "integer_standard_std"

    body = HS.MDo $ concat [
          fix_undeclared_integer
        , gen_elab_constants ts
        , gen_elab_types ts
        , gen_elab_proc ts
        , gen_elab_decls ts
        , [gen_return_ unit_con]
        ]

    fix_undeclared_integer
        | has_type_declaration name_of_integer ts = []
        | otherwise =
            [gen_function_ret name_of_integer "alloc_unranged_type" []]

    -- HACK: lift all the constants
    gen_elab_constants [] = []
    gen_elab_constants ((IRTConstant c):ts) = (gen_alloc_constant c) ++ (gen_elab_constants ts)
    gen_elab_constants (t:ts) = gen_elab_constants ts

    -- HACK: lift all the types
    gen_elab_types [] = []
    gen_elab_types ((IRTType t):ts) = (gen_alloc_type t) ++ (gen_elab_types ts)
    gen_elab_types (t:ts) = gen_elab_types ts

    -- HACK: lift all the procedures
    gen_elab_proc [] = []
    gen_elab_proc ((IRTProcedure p):ts) = (gen_alloc_procedure p) ++ (gen_elab_proc ts)
    gen_elab_proc ((IRTFunction p):ts) = (gen_alloc_function p) ++ (gen_elab_proc ts)
    gen_elab_proc (t:ts) = gen_elab_proc ts

    gen_elab_decls [] = []
    gen_elab_decls ((IRTSignal s):ts) = (gen_alloc_signal s) ++ (gen_elab_decls ts)
    gen_elab_decls ((IRTPort p):ts) = (gen_alloc_port p) ++ (gen_elab_decls ts)
    gen_elab_decls ((IRTProcess p):ts) = (gen_alloc_process p) ++ (gen_elab_decls ts)
    gen_elab_decls (t:ts) = gen_elab_decls ts

    gen_elab_letdecls ls = concat $ map map_let ls where
        map_let (ILDConstant c) = gen_alloc_constant c
        map_let (ILDVariable v) = gen_alloc_variable v
        map_let (ILDProcedure p) = gen_alloc_procedure p
        map_let (ILDFunction p) = gen_alloc_function p
        map_let e = perror "%s\ngen_let: only variables, constants or procedures, please"
            (show e)

    gen_range_c (Constrained _ c) = gen_arr_range c
    gen_range_c (Unconstrained c) = gen_arr_range c

    gen_arr_range (IRARDConstrained loc tn (IRDRange loc2 a DirTo b)) = 
        gen_appl "alloc_range" [gen_elab_expr a, gen_elab_expr b]
    gen_arr_range (IRARDTypeMark loc t) =
        gen_ident "alloc_urange"
    gen_arr_range (IRARDRange (IRDRange _ a DirTo b)) =
        gen_appl "alloc_range" [gen_elab_expr a, gen_elab_expr b]
    gen_arr_range s = perror
        "%s\ngen_arr_range: a-to-b ranges or <>, please" (PP.ppShow s)

    gen_range (IRDRange loc a DirTo b) = 
        gen_appl "alloc_range" [gen_elab_expr a, gen_elab_expr b]
    -- gen_range (IRDARange loc exp name) = error "range undefined"
    -- gen_range (IRDAReverseRange _ exp name) = error "range undefined"
    gen_range s = perror
        "%s\ngen_range: a-to-b ranges or <>, please" (PP.ppShow s)

    gen_alloc_type (IRType p (ITDArray [c] t)) = [
          gen_function_ret (unHierPath p) "alloc_array_type" [
              gen_range_c c
            -- , name_of_integer
            , gen_type_ident t
            ] ]

    gen_alloc_type (IRType p (ITDConstraint _ t [c])) = [
        gen_function_ret (unHierPath p) "alloc_subtype" [
              gen_arr_range c
            , gen_type_ident t
            ] ]

    gen_alloc_type (IRType p (ITDRangeDescr r)) = [
        gen_function_ret (unHierPath p) "alloc_ranged_type" [
              gen_range r
            ] ]

    gen_alloc_type (IRType p (ITDEnum es)) = [
        gen_function pat "alloc_enum_type" [
              gen_ident (show $ length es)
            ] ]
        where 
            pat = gen_pat_pair [gen_pat (unHierPath p), gen_pat_list (map epat es)]
            short s = intercalate "_" ("enum":s)
            epat (EnumId i) = gen_pat i
            epat (EnumChar ' ') = gen_pat "enum_space"
            epat (EnumChar c)
                | isAlphaNum c = gen_pat (short [[c]])
                | otherwise = gen_pat (short ["ord", (show $ ord c)])

    gen_alloc_type (IRType p t) = [] -- perror "%s\ngen_alloc_type: ITDArray only, please" (show t)

    gen_alloc_signal (IRSignal p t (IOEJustExpr _ e)) = [
          gen_function_ret (unHierPath p) "alloc_signal" [
              gen_str $ unHierPath p
            , gen_type_ident t
            , gen_assign_or_aggregate gen_elab_expr e
            ]
        ]
    gen_alloc_signal (IRSignal p (ITDName t) (IOENothing loc)) = [
          gen_function_ret (unHierPath p) "alloc_signal" [
              gen_str $ unHierPath p, gen_ident $ unHierPath t, gen_defval
            ]
        ]
    gen_alloc_signal _ = error $ concat [
          "gen_alloc_signal: want default value expression for simple signal"
        , "gen_alloc_signal: or simple int array without default val"
        ]

    gen_alloc_port (IRPort p t (IOEJustExpr _ e)) = [
          gen_function_ret (unHierPath p) "alloc_port" [
              gen_str (unHierPath p)
            , gen_type_ident t
            , gen_assign_or_aggregate gen_elab_expr e
            ]
        ]

    gen_alloc_constant (IRConstant p t loc e) = [
          gen_function_ret' (unHierPath p) (
            appl_alloc_constant
              (gen_type_ident t)
              (gen_assign_or_aggregate gen_elab_expr e)
            )
        ]

    build_alloc_variable p t x =
        gen_function_ret p "alloc_variable" [
              gen_str p
            , gen_type_ident t
            , x
            ]

    gen_alloc_variable (IRVariable p t (IOEJustExpr _ e)) =
        [ build_alloc_variable (unHierPath p) t (gen_assign_or_aggregate gen_elab_expr e) ]
    gen_alloc_variable (IRVariable p t (IOENothing _)) =
        [ build_alloc_variable (unHierPath p) t (gen_defval) ]

    gen_elab_expr (IEInt loc i) = gen_appl "int" [gen_int i]
    gen_elab_expr (IEName loc n) = gen_name gen_elab_expr n
    gen_elab_expr e = perror "gen_elab_expr: int constants only, please (got %s)" (show e)

    gen_alloc_process (IRProcess p ns lets s) = [
          gen_function_ret (unHierPath p) "alloc_process_let" [
              gen_str $ unHierPath p
            , gen_list $ map scan_sens ns
            , HS.Paren $ HS.Do $
                (gen_elab_letdecls lets) ++
                [gen_return_ (gen_seq s)]
            ]
        ]
        where
            scan_sens (INIdent hp) = gen_ident $ unHierPath hp
            scan_sens s = perror "%s\nscan_sens: use idents, please" (show s)

    gen_let_func n pats stmts =
        gen_function_ret n "alloc_function" [HS.Paren $ HS.Lambda noLoc pats stmts]
        -- HsLetStmt [HS.FunBind [HS.Match noLoc n pats body []]] 
        -- where
            -- body = HS.UnGuardedRhs $ stmts

    -- Generates a procedure declaration
    gen_alloc_procedure (IRProcedure p as stmt) = [
          gen_let_func (unHierPath p) (map arg' as) (gen_let stmt) ] where

        arg' (IRArg n _ _ _) = gen_pat (mangle' n)

        gen_arg (IRArg n t NIKVariable AMIn) = [
              build_alloc_variable n t
                (gen_assign [gen_appl "pure" [gen_ident $ mangle' n]])
            ]
        gen_arg (IRArg n t _ _) = [ 
              gen_function_ret n "assume_subtype_of" [gen_type_ident t, (gen_ident (mangle' n))]
            ]

        gen_let (ISLet ldecls ss) = HS.Paren $ HS.Do $
            (concat $ map gen_arg as) ++
            (gen_elab_letdecls ldecls) ++
            [gen_return_ (gen_seq ss)]

        gen_let ss = HS.Paren $ HS.Do $
            (concat $ map gen_arg as) ++
            [gen_return_ (gen_seq ss)]

    gen_alloc_function (IRFunction p as _ stmt) =
        -- Note: (gen_stmt ret) handles return type
        gen_alloc_procedure (IRProcedure p as stmt)

    type_name_is pat n = gen_ident pat == gen_type_ident n

    gen_type_ident :: IRTypeDescr -> HS.Exp
    gen_type_ident (ITDName p) = gen_ident $ unHierPath p
    gen_type_ident t = perror "%s\ngen_type_ident: name types with single idents, please"
        (show t)

    gen_name f (IRName n _) = gen_name' n where
        gen_name' (INIdent p) = gen_appl "pure" [gen_ident $ unHierPath p]
        gen_name' (INIndex _ p _ [(_,e)]) = gen_appl "index" [f e, gen_name' p]
        gen_name' n = perror "%s\ngen_name: ident or index please" (PP.ppShow n)

    -- Generate sequentional statements in a do-wrapper
    gen_seq ss = HS.Paren $ HS.Do $ gen_stmt ss where

        gen_stmt (ISSeq a b) = gen_stmt a ++ gen_stmt b
        gen_stmt (ISAssign _ n _ e) = [
              gen_function_ "(.=.)" [
                  gen_name gen_expr n
                , gen_assign_or_aggregate gen_expr e
                ]
            ]
        gen_stmt (ISSignalAssign _ n _ []) = error "gen_stmt: no afters"
        gen_stmt (ISSignalAssign _ n _ [IRAfter e t]) = [
              gen_function_ "(.<=.)" [
                  gen_name gen_expr n
                , gen_pair [
                      maybe (gen_ident "next") (gen_expr) t
                    , gen_assign_or_aggregate gen_expr e
                    ]
                ]
            ]
        gen_stmt (ISSignalAssign _ n _ afters) = [
              gen_function_ "(.<<=.)" [
                  gen_name gen_expr n
                , gen_list $ map gen_after afters
                ]
            ]
            where
                gen_after (IRAfter e t) = gen_pair [
                      maybe (gen_ident "next") (gen_expr) t
                    , gen_assign_or_aggregate gen_expr e
                    ]

        gen_stmt (ISNop loc) = [gen_function_ "return" [unit_con]]
        gen_stmt (ISNil) = [gen_function_ "return" [unit_con]]
        gen_stmt (ISIf loc e s1 s2) = [
              gen_function_ "iF" [
                  gen_expr e
                , HS.Paren $ HS.Do $ gen_stmt s1
                , HS.Paren $ HS.Do $ gen_stmt s2
                ]
            ]
        gen_stmt (ISAssert loc e1 e2 e3) = [gen_function_ "assert" []]
        gen_stmt (ISReport loc e1 e2) = [gen_function_ "report" [gen_expr e1]]
        gen_stmt (ISWait loc [] Nothing (Just e)) = [gen_function_ "wait" [gen_expr e]]
        gen_stmt (ISWait loc [] Nothing Nothing) = [gen_function_ "wait" [gen_ident "next"]]
        gen_stmt (ISFor lbl loc i (ITDRangeDescr range) s) = gen_for range i s
        gen_stmt (ISReturn loc) = [gen_function_ "retp" [unit_con]]
        gen_stmt (ISReturnExpr loc e) = [
              gen_function_ "retf" [
                  appl_alloc_constant
                    (gen_type_ident (find_fun_type loc ts))
                    (gen_assign_or_aggregate gen_expr e)
                ]
            ]
        gen_stmt (ISProcCall n args loc) = [gen_function_ "call" [
            gen_op_chain "<<" (gen_ident (unHierPath n) : map (gen_expr . snd) args)
            ]]
        gen_stmt e = error $ "gen_stmt: unknown stmt: " ++ show e

        gen_for (IRDRange loc e1 dir e2) ei s = [
              gen_function_ "for" [
                  gen_pair [gen_expr e1, gen_ident "To", gen_expr e2]
                , gen_lambda ei (gen_stmt s) 
                ]
            ]

        gen_expr (IEInt loc i) = gen_appl "int" [gen_int i]
        gen_expr (IEString loc bs) = gen_appl "str" [gen_str $ BS.unpack bs]
        gen_expr (IEName loc n) = gen_name gen_expr n
        gen_expr (IEBinOp loc IPlus e1 e2) = gen_appl "add" [gen_expr e1, gen_expr e2]
        gen_expr (IEBinOp loc IConcat e1 e2) = gen_op ".++." (gen_expr e1) (gen_expr e2)
        gen_expr (IERelOp loc IGreaterEqual _ e1 e2) =
            gen_appl "greater_eq" [gen_expr e1, gen_expr e2]
        gen_expr (IEPhysical val un) = gen_appl un [gen_int val]
        -- FIXME: only signals can be imaged, but noone prevents user from
        -- imaging arrays or records
        -- gen_expr (IETypeValueAttr loc T_image e t)
        --     | type_name_is name_of_integer t = gen_appl "t_image" [gen_expr e, gen_type_ident t]
        --     | otherwise = perror "%s\ngen_expr: image integers only, please" (show t)
        gen_expr (IETypeValueAttr loc T_image e t) = gen_appl "t_image" [
            gen_expr e, gen_type_ident t]
        gen_expr (IEFunctionCall n args loc) = gen_appl "call" [
              gen_op_chain "<<" (gen_ident n : map (gen_expr . snd) args)
            ]
        gen_expr e = perror "%s\ngen_expr: unsupported expr" (show e)

gen_import m = HS.ImportDecl noLoc (ModuleName m) False False Nothing Nothing Nothing

gen_main = (:[]) $ HS.FunBind [HS.Match noLoc (HS.Ident "main") [] Nothing (HS.UnGuardedRhs body) (BDecls [])]
    where
        body = HS.Do [gen_function_ "sim" [gen_ident "maxBound", gen_ident "elab" ]]

gen_module :: [IRTop] -> HS.Module
gen_module ts = HS.Module noLoc (ModuleName "Main") pragmas Nothing Nothing imports body where
    imports = [
          gen_import "VSim.Runtime"
        ]
    body = concat [
          gen_elab ts
        , gen_main
        ]
    pragmas = [
          LanguagePragma noLoc [Ident "DoRec"]
        ]

prettyPrintM tops = putStrLn $ prettyPrint $ gen_module tops

vsim :: [FilePath] -> IO ()
vsim files = do
    ps <- parseFiles files
    prettyPrintM ps

main = do
    getArgs >>= vsim

