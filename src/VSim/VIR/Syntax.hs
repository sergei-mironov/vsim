module VSim.VIR.Syntax where

import Data.List
import qualified Data.ByteString as BS

import Control.Monad
import Control.Monad.State
import Control.Monad.Trans

import Language.Haskell.Syntax
import Language.Haskell.Pretty

import VSim.Data.Loc
import VSim.VIR.Types


data HGenState = HGS {
    {- nothing -}
    } deriving(Show)

type HGen m a = StateT HGenState m a

makeIdent :: WLHierNameWPath -> HsName
makeIdent (WithLoc _ (n,ns)) = intercalate "_" $ (BS.unpack n) : (map BS.unpack ns)

declareSignal :: (Monad m) => IRSignal -> HGen m [HsStmt]
declareSignal (IRSignal n t (IOEJustExpr _ _)) = error "not supported"
declareSignal (IRSignal n t (IOENothing _)) = concat [
    ]

