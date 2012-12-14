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
    deriving(Show, Data, Typeable)

data UnitDecl = UnitDecl Loc Ident Int128 Ident
    deriving (Show, Data, Typeable)

data Constrained t
    = Unconstrained t
    | Constrained Bool t
    deriving (Show, Eq, Data, Typeable)

-- | Диапазон адресов, четвёрка:
-- ( суффикс процессора в иерархии , суффикс сигнала с адресами
-- , стартовый адрес , конечный адрес (не включается)).
data MemoryMapRange = MemoryMapRange [B.ByteString] [B.ByteString] Integer Integer
    deriving (Show, Data, Typeable)
    
data IRProcess
    = IRProcess WLHierNameWPath [IRNameG] [IRLetDecl] IRStat
    deriving(Show, Data, Typeable)

data IRGen
    = IRGenIf IRExpr [IRTop]
    | IRGenFor String WLHierNameWPath Integer Integer [IRTop]
    deriving(Show, Data, Typeable)

data IRType = IRType WLHierNameWPath IRTypeDescr
    deriving(Show, Data, Typeable)

data IRTypeDescr
    = ITDName WLHierNameWPath
    | ITDRangeDescr IRRangeDescr
    | ITDEnum [EnumElement]
    | ITDArray [Constrained IRArrayRangeDescr] IRTypeDescr
    | ITDPhysical IRRangeDescr Ident [UnitDecl]
    | ITDRecord [(Loc, Ident, IRTypeDescr)]
    | ITDAccess IRTypeDescr
    | ITDResolved Loc Ident IRTypeDescr
    | ITDConstraint Loc IRTypeDescr [IRArrayRangeDescr]
    deriving (Show, Data, Typeable)

data Direction = DirTo | DirDownto
    deriving(Show, Data, Typeable)

data IRRangeDescr
    = IRDRange Loc IRExpr Direction IRExpr
    | IRDARange Loc IRExpr IRName
    | IRDAReverseRange Loc IRExpr IRName
    deriving (Show, Data, Typeable)

data IRArrayRangeDescr
    = IRARDRange IRRangeDescr
    | IRARDTypeMark Loc IRTypeDescr
    | IRARDConstrained Loc IRTypeDescr IRRangeDescr
    --  ^ вместо IRTypeDescr был TypeMark, но с ним фиг передашь статичность
    deriving (Show, Data, Typeable)

data IRElementAssociation
    = IEAExpr Loc IRExpr
    | IEAOthers Loc IRExpr
    | IEAType Loc IRArrayRangeDescr IRExpr
    | IEAField Loc Ident IRExpr
    | IEAExprIndex Loc IRExpr IRExpr
    deriving (Show, Data, Typeable)

data IRNameG
    = INAggregate Loc [IRElementAssociation] IRTypeDescr
    | INIdent WLHierNameWPath
    | INField IRNameG Loc Ident
    | INIndex NameExprKind IRNameG Loc IREGList
    | INSlice NameExprKind IRNameG Loc IRArrayRangeDescr
    deriving (Show, Data, Typeable)

type IREGList = [(Loc, IRExpr)]

data NameCheck = ExprCheck | AssignCheck | SignalCheck | TypeCheck
    deriving (Show, Data, Typeable)

data IRName = IRName IRNameG NameCheck
    deriving (Show, Data, Typeable)

-- | Old VIR parser legacy. FIXME: remove it from this layer
data NameExprKind
    = NEKStatic [B.ByteString]
    -- ^ string suffix
    | NEKDynamic
    deriving (Show, Data, Typeable)

data IRTypeAttr
    = T_left
    | T_right
    | T_high
    | T_low
    | T_ascending
    deriving (Show, Data, Typeable)

data IRTypeValueAttr
    = T_succ
    | T_pred
    | T_val
    | T_pos
    | T_image
    deriving (Show, Data, Typeable)

data IRArrayAttr
    = A_left
    | A_right
    | A_high
    | A_low
    | A_ascending
    | A_length
    deriving (Show, Data, Typeable)

data IRValueAttr
    = V_image
    | V_value
    | V_pos
    | V_val
    | V_succ
    | V_pred
    | V_leftof
    | V_rightof
    deriving (Show, Data, Typeable)

data IRSignalAttr
    = S_event
    | S_active
    | S_last_value
    deriving (Show, Data, Typeable)

data IRSignalAttrTimed
    = S_stable
    | S_delayed
    | S_quiet
    deriving (Show, Data, Typeable)

data IRRelOp
    = IEq
    | INeq
    | ILess
    | ILessEqual
    | IGreater
    | IGreaterEqual
    deriving (Show, Data, Typeable)

data IRBinOp
    = IMod | IRem | IDiv | IPlus | IMinus | IMul | IExp
    | IAnd | INand | IOr | INor | IXor | IXNor
    | IConcat
    deriving (Show, Data, Typeable)

data IRUnOp
    = IUPlus | IUMinus | IAbs | INot
    deriving (Show, Data, Typeable)

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
    deriving (Show, Data, Typeable)

data IRGenericBinOp = IRGenericDiv | IRGenericMul
    deriving (Show, Data, Typeable)

data IRAfter
    = IRAfter IRExpr (Maybe IRExpr)
    -- ^      value  time
    deriving (Show, Data, Typeable)

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
    deriving (Show, Data, Typeable)

data IRCaseElement
    = ICEExpr   Loc IREGList IRStat
    | ICEOthers Loc IRStat
    deriving (Show, Data, Typeable)

data IRLetDecl
    = ILDConstant  IRConstant
    | ILDVariable  IRVariable
    | ILDAlias     IRAlias
    | ILDType      WLHierNameWPath IRTypeDescr
    | ILDFunction  IRFunction
    | ILDProcedure IRProcedure
    deriving (Show, Data, Typeable)

data IRConstant = IRConstant WLHierNameWPath IRTypeDescr Loc IRExpr
    deriving (Show, Data, Typeable)
data IRVariable = IRVariable WLHierNameWPath IRTypeDescr IROptExpr
    deriving (Show, Data, Typeable)
data IRSignal   = IRSignal   WLHierNameWPath IRTypeDescr IROptExpr
    deriving (Show, Data, Typeable)
data IRPort     = IRPort     WLHierNameWPath IRTypeDescr IROptExpr
    deriving (Show, Data, Typeable)
data IRAlias    = IRAlias    WLHierNameWPath IRTypeDescr Loc IRName
    deriving (Show, Data, Typeable)

data IROptExpr
    = IOEJustExpr Loc IRExpr
    | IOENothing  Loc
    deriving (Show, Data, Typeable)

data IRFunction = IRFunction WLHierNameWPath [IRArg] IRTypeDescr IRStat
    deriving (Show, Data, Typeable)
data IRProcedure = IRProcedure WLHierNameWPath [IRArg] IRStat
    deriving (Show, Data, Typeable)

data ArgMode
    = AMIn
    | AMOut
    | AMInout
    deriving (Show, Eq, Data, Typeable)

data NamedItemKind
    = NIKConstant
    | NIKVariable
    | NIKSignal
    | NIKFile
    | NIKAlias NamedItemKind
    deriving (Show, Eq, Ord, Data, Typeable)

data IRArg = IRArg (WithLoc Ident) IRTypeDescr NamedItemKind ArgMode
    deriving (Show, Data, Typeable)

data LetEnv = LetEnv {
      leCurFunc :: LetName
    , leCurPath :: Ident
    , leCurLevel :: Int
    , leFuncs :: [LetName]
    , leVars  :: [LetName]
    , leTypes :: [LetName]
    }
    deriving (Show, Data, Typeable)

data LetName = LetName {
      -- | var1
      lnName :: Ident
      -- | .func.
    , lnPath :: Ident
    , lnLevel :: Int
    }
    deriving (Eq, Ord, Data, Typeable)

instance Show LetName where
    show (LetName {..}) = "\"" ++ unpack (append lnPath lnName)
                          ++ "[" ++ show lnLevel ++ "]\""

type LetUsageMap = Map LetName (Set LetName)

