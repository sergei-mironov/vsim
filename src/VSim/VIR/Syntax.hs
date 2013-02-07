module VSim.VIR.Syntax where

import Data.List
import qualified Data.ByteString.Char8 as BS

import Control.Monad
import Control.Monad.State
import Control.Monad.Trans

import VSim.Data.Loc
import VSim.VIR.Types

{-

data HGenState = HGS {
    {- nothing -}
    } deriving(Show)

type HGen m a = StateT HGenState m a

makeIdent :: WLHierNameWPath -> HsName
makeIdent (WithLoc _ (n,ns)) = HsIdent $ intercalate "_" $ (BS.unpack n) : (map BS.unpack ns)

declareSignal :: (Monad m) => IRSignal -> HGen m [HS.Stmt]
declareSignal (IRSignal n t (IOEJustExpr _ _)) = error "not supported"
declareSignal (IRSignal n t (IOENothing _)) = return $ concat [ ]

-}
