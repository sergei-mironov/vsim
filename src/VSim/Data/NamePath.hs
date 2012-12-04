{-# LANGUAGE ViewPatterns, OverloadedStrings #-}
{-# LANGUAGE DeriveDataTypeable #-}

module VSim.Data.NamePath (
      Ident
    , NamePathElem
    ) where

import Data.Typeable
import Data.Generics
import Data.Bits (xor)
import qualified Data.ByteString.Char8 as B
import Data.List
import Data.Maybe
import Control.Monad
import System.IO
import Data.Char
import Data.Int


bsToFs = id
fsToBs = id

type Ident  = B.ByteString


type OverloadIndex = Integer

-- | Элемент пути к имени, используется при выводе деревьев значений
-- для отладчика и при генерации статических имен.
data NamePathElem
    = NPELibrary Ident
    | NPEFile Ident
    | NPEPackage Ident
    | NPEEntity Ident
    | NPEProcess Ident
    | NPEFunction OverloadIndex Ident
    -- | NPEProcedure Ident -- OverloadIndex
    | NPEType Ident
    | NPEIdent NamedItemKind Ident
    | NPEIndex [B.ByteString]
    -- ^ не ident, чтобы не засирать таблицу с атомами
    | NPESlice B.ByteString
    | NPEField Ident
    | NPEDeref
    | NPECIndex [B.ByteString]
    | NPECDeref
    -- | Дополнительный идентификатор в имени, делающий его
    -- уникальным. Используется в UI (чтобы одна и та же ф-ия на
    -- разной глубине callStack-а была разной, возможно, где-нить
    -- еще пригодится)
    | NPEId B.ByteString NamePathElem
    deriving (Show, Eq, Ord, Data, Typeable)

isProcessRevPath (stripNPEIds -> (NPEProcess _ : _)) = True
isProcessRevPath _ = False

isConstantRevPath = isJust . find c . stripNPEIds
    where c (NPEIdent nik _) = skipAliases nik == NIKConstant
          c _                = False

stripNPEIds [] = []
stripNPEIds (NPEId _ pe : pes) = stripNPEIds (pe : pes)
stripNPEIds (pe : pes) = pe : stripNPEIds pes

-- | Путь к имени, записывается задом наперед для удобства дальнейшей
-- работы (ну и, мимоходом, шарятся префиксы)
type RevNamePath = [NamePathElem]

data NamedItemKind
    = NIKConstant
    | NIKVariable
    | NIKSignal
    | NIKFile
    | NIKAlias NamedItemKind
    deriving (Show, Eq, Ord, Data, Typeable)

niKindToString nik = case nik of
    NIKConstant -> "constant"
    NIKVariable -> "variable"
    NIKSignal -> "signal"
    NIKFile -> "file"
    NIKAlias anik -> niKindToString anik ++ " alias"

skipAliases (NIKAlias a) = skipAliases a
skipAliases n = n

