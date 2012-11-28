{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DeriveDataTypeable #-}

module VSim.VIR.Types where

import Data.ByteString.Char8 as B
import Data.Map (Map)
import Data.Set (Set)
import Data.Data
import Data.Typeable
import Data.Generics

import VSim.Data.Loc
import VSim.Data.Int128
import VSim.Data.TInt
import VSim.Data.NamePath (Ident)
import VSim.VIR.Lexer as L

-- type Ident = B.ByteString

-- | VIR-file toplevel decarations
data IRTop
    = IRTProcess IRProcess
    | IRTFunction IRFunction
    | IRTType IRType
    | IRTConstant IRConstant
    | IRTSignal IRSignal
    | IRTAlias IRAlias
    | IRTPort IRPort
    | IRTProcedure IRProcedure
    | IRTGenerate IRGen
    | IRTMM MemoryMapRange
    | IRTCorresp ([Ident],[Ident])
    deriving(Show)

data UnitDecl = UnitDecl Loc Ident Int128 Ident
    deriving (Show)

data Constrained t
    = Unconstrained t
    | Constrained Bool t
    deriving (Show, Eq)

-- | Диапазон адресов, четвёрка:
-- ( суффикс процессора в иерархии , суффикс сигнала с адресами
-- , стартовый адрес , конечный адрес (не включается)).
data MemoryMapRange = MemoryMapRange [B.ByteString] [B.ByteString] Integer Integer
    deriving (Show)
    
data IRProcess
    = IRProcess WLHierNameWPath [IRNameG] [IRLetDecl] IRStat
    deriving(Show)

data IRGen
    = IRGenIf IRExpr [IRTop]
    | IRGenFor String WLHierNameWPath Integer Integer [IRTop]
    deriving(Show)

data IRType = IRType WLHierNameWPath IRTypeDescr
    deriving(Show)

data IRTypeDescr
    = ITDName (WithLoc Ident)
    | ITDRangeDescr IRRangeDescr
    | ITDEnum [EnumElement]
    | ITDArray [Constrained IRArrayRangeDescr] IRTypeDescr
    | ITDPhysical IRRangeDescr Ident [UnitDecl]
    | ITDRecord [(Loc, Ident, IRTypeDescr)]
    | ITDAccess IRTypeDescr
    | ITDResolved Loc Ident IRTypeDescr
    | ITDConstraint Loc IRTypeDescr [IRArrayRangeDescr]
    deriving (Show)

data IRRangeDescr
    = IRDRange Loc IRExpr Bool IRExpr
    | IRDARange Loc IRExpr IRName
    | IRDAReverseRange Loc IRExpr IRName
    deriving (Show)

data IRArrayRangeDescr
    = IRARDRange IRRangeDescr
    | IRARDTypeMark Loc IRTypeDescr
    | IRARDConstrained Loc IRTypeDescr IRRangeDescr
    --  ^ вместо IRTypeDescr был TypeMark, но с ним фиг передашь статичность
    deriving (Show)

data IRElementAssociation
    = IEAExpr Loc IRExpr
    | IEAOthers Loc IRExpr
    | IEAType Loc IRArrayRangeDescr IRExpr
    | IEAField Loc Ident IRExpr
    | IEAExprIndex Loc IRExpr IRExpr
    deriving (Show)

data IRNameG
    = INAggregate Loc [IRElementAssociation] IRTypeDescr
    | INIdent WLHierNameWPath
    | INField IRNameG Loc Ident
    | INIndex NameExprKind IRNameG Loc IREGList
    | INSlice NameExprKind IRNameG Loc IRArrayRangeDescr
    deriving (Show)

type IREGList = [(Loc, IRExpr)]

data NameCheck = ExprCheck | AssignCheck | SignalCheck | TypeCheck
    deriving (Show)

data IRName = IRName IRNameG NameCheck
    deriving (Show)

-- | Old VIR parser legacy. FIXME: remove it from this layer
data NameExprKind
    = NEKStatic [B.ByteString]
    -- ^ string suffix
    | NEKDynamic
    deriving (Show)

data IRTypeAttr
    = T_left
    | T_right
    | T_high
    | T_low
    | T_ascending
    deriving (Show)

data IRTypeValueAttr
    = T_succ
    | T_pred
    | T_val
    | T_pos
    deriving (Show)

data IRArrayAttr
    = A_left
    | A_right
    | A_high
    | A_low
    | A_ascending
    | A_length
    deriving (Show)

data IRValueAttr
    = V_image
    | V_value
    | V_pos
    | V_val
    | V_succ
    | V_pred
    | V_leftof
    | V_rightof
    deriving (Show)

data IRSignalAttr
    = S_event
    | S_active
    | S_last_value
    deriving (Show)

data IRSignalAttrTimed
    = S_stable
    | S_delayed
    | S_quiet
    deriving (Show)

data IRRelOp
    = IEq
    | INeq
    | ILess
    | ILessEqual
    | IGreater
    | IGreaterEqual
    deriving (Show)

data IRBinOp
    = IMod | IRem | IDiv | IPlus | IMinus | IMul | IExp
    | IAnd | INand | IOr | INor | IXor | IXNor
    | IConcat
    deriving (Show)

data IRUnOp
    = IUPlus | IUMinus | IAbs | INot
    deriving (Show)

data IRExpr
    = IEName       Loc IRName
    | IEString     Loc B.ByteString
    | IEAggregate  Loc [IRElementAssociation]
    | IEQualifyType  Loc IRTypeDescr IRExpr
    | IEVQualifyType Loc IRTypeDescr IRTypeDescr IRExpr
    | IETypeAttr   Loc IRTypeAttr IRTypeDescr
    | IETypeValueAttr   Loc IRTypeValueAttr IRExpr IRTypeDescr
    | IEArrayAttr  Loc IRArrayAttr IRExpr IRName
    | IESignalAttr Loc IRSignalAttr IRName
    | IESignalAttrTimed Loc IRSignalAttrTimed IRName IRExpr
    | IEEnumIdent  Loc EnumElement
    | IEInt        Loc TInt
    | IEDouble     Loc Double
    | IEPhysical   (WithLoc Int128) (WithLoc Ident)
    | IEFunctionCall (WithLoc Ident) IREGList Loc
    | IERelOp      Loc IRRelOp IRTypeDescr IRExpr IRExpr
    | IEGenericBinop Loc IRGenericBinOp
        IRTypeDescr IRTypeDescr IRExpr IRExpr
    | IEBinOp      Loc IRBinOp IRExpr IRExpr
    | IEUnOp       Loc IRUnOp IRExpr
    | IECurrentTime Loc
    deriving (Show)

data IRGenericBinOp = IRGenericDiv | IRGenericMul
    deriving (Show)

data IRAfter
    = IRAfter IRExpr (Maybe IRExpr)
    -- ^      value  time
    deriving (Show)

type WLHierNameWPath = WithLoc (Ident, [Ident])

type LoopLabel = Ident

data IRStat
    = ISReturn Loc
    | ISReturnExpr Loc IRExpr
    | ISProcCall (WithLoc Ident) IREGList Loc
    | ISIf Loc IRExpr IRStat IRStat
    | ISLet [IRLetDecl] IRStat
    | ISAssign Loc IRName Loc IRExpr
    | ISSignalAssign Loc IRName Loc [IRAfter]
    | ISAssert Loc IRExpr IRExpr IRExpr -- expr report severity
    | ISReport Loc IRExpr IRExpr        -- report severity
    | ISWait  Loc [IRNameG] (Maybe IRExpr) (Maybe IRExpr) -- on until for
    | ISNop   Loc
    | ISCase  Loc IRExpr IRTypeDescr [IRCaseElement]
    | ISFor   LoopLabel Loc (WithLoc Ident) IRTypeDescr IRStat
    | ISWhile LoopLabel Loc IRExpr IRStat
    | ISSeq   IRStat IRStat
    | ISExit  Loc LoopLabel
    | ISNext  Loc LoopLabel
    | ISNil
    deriving (Show)

data IRCaseElement
    = ICEExpr   Loc IREGList IRStat
    | ICEOthers Loc IRStat
    deriving (Show)

data IRLetDecl
    = ILDConstant  IRConstant
    | ILDVariable  IRVariable
    | ILDAlias     IRAlias
    | ILDType      WLHierNameWPath IRTypeDescr
    | ILDFunction  IRFunction
    | ILDProcedure IRProcedure
    deriving (Show)

data IRConstant = IRConstant WLHierNameWPath IRTypeDescr Loc IRExpr
    deriving (Show)
data IRVariable = IRVariable WLHierNameWPath IRTypeDescr IROptExpr
    deriving (Show)
data IRSignal   = IRSignal   WLHierNameWPath IRTypeDescr IROptExpr
    deriving (Show)
data IRPort     = IRPort     WLHierNameWPath IRTypeDescr IROptExpr
    deriving (Show)
data IRAlias    = IRAlias    WLHierNameWPath IRTypeDescr Loc IRName
    deriving (Show)

data IROptExpr
    = IOEJustExpr Loc IRExpr
    | IOENothing  Loc
    deriving (Show)

data IRFunction = IRFunction WLHierNameWPath [IRArg] IRTypeDescr IRStat
    deriving (Show)
data IRProcedure = IRProcedure WLHierNameWPath [IRArg] IRStat
    deriving (Show)

data ArgMode
    = AMIn
    | AMOut
    | AMInout
    deriving (Show, Eq)

data NamedItemKind
    = NIKConstant
    | NIKVariable
    | NIKSignal
    | NIKFile
    | NIKAlias NamedItemKind
    deriving (Show, Eq, Ord)

data IRArg = IRArg (WithLoc Ident) IRTypeDescr NamedItemKind ArgMode
    deriving (Show)

data LetEnv = LetEnv {
      leCurFunc :: LetName
    , leCurPath :: Ident
    , leCurLevel :: Int
    , leFuncs :: [LetName]
    , leVars  :: [LetName]
    , leTypes :: [LetName]
    }
    deriving (Show)

data LetName = LetName {
      -- | var1
      lnName :: Ident
      -- | .func.
    , lnPath :: Ident
    , lnLevel :: Int
    }
    deriving (Eq, Ord)

instance Show LetName where
    show (LetName {..}) = "\"" ++ unpack (append lnPath lnName)
                          ++ "[" ++ show lnLevel ++ "]\""

type LetUsageMap = Map LetName (Set LetName)

