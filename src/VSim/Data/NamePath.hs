{-# LANGUAGE ViewPatterns, OverloadedStrings #-}

module VSim.Data.NamePath (
      Ident
    , NamePathElem
    ) where

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
-- readInteger  = readSigned readUnsignedInteger
-- readInt      = readSigned readUnsignedInt

-- import Lib.GHCAPI.FastString
-- import Utils.ReadUtils

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
--    | NPEProcedure Ident -- OverloadIndex
    | NPEType Ident
    | NPEIdent NamedItemKind Ident
    | NPEIndex [B.ByteString]
      --        ^ не ident, чтобы не засирать таблицу с атомами
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
    deriving (Show, Eq, Ord)

-- type NamePathElemHash = Int

isProcessRevPath (stripNPEIds -> (NPEProcess _ : _)) = True
isProcessRevPath _ = False

isConstantRevPath = isJust . find c . stripNPEIds
    where c (NPEIdent nik _) = skipAliases nik == NIKConstant
          c _                = False

stripNPEIds [] = []
stripNPEIds (NPEId _ pe : pes) = stripNPEIds (pe : pes)
stripNPEIds (pe : pes) = pe : stripNPEIds pes

{-
namePathElemHash :: NamePathElem -> NamePathElemHash
namePathElemHash npe = case npe of
    NPELibrary i -> uniq i
    NPEFile i -> uniq i
    NPEPackage i -> uniq i
    NPEEntity i -> uniq i
    NPEProcess i -> uniq i
    NPEFunction oi i -> xor (fromEnum oi) $ uniq i
    NPEType i -> uniq i
    NPEIdent _ i -> uniq i
    NPEIndex i -> fromEnum $ foldl xor 0 $ map hashBs i
    NPECIndex i -> fromEnum $ foldl xor 0 $ map hashBs i
    NPESlice i -> fromEnum $ hashBs i
    NPEField i -> uniq i
    NPEDeref -> 0
    NPECDeref -> 0
    NPEId i pe -> fromEnum (hashBs i) `xor` namePathElemHash pe

hashBs = B.foldl' f golden
   where f m c = fromIntegral (ord c) * magic + m
         magic = 0xdeadbeef
         golden :: Int32
         golden = 1013904242 -- = round ((sqrt 5 - 1) * 2^32) :: Int32
-}

-- revNamePathHash :: RevNamePath -> NamePathElemHash
-- revNamePathHash = foldl xor 0 . map namePathElemHash

-- | Ключ для быстрого поиска по имени в Map-ах
-- type RevNamePathKey = (NamePathElemHash, RevNamePath)

-- revNamePathKey p = (revNamePathHash p, p)

-- | Путь к имени, записывается задом наперед для удобства дальнейшей
-- работы (ну и, мимоходом, шарятся префиксы)
type RevNamePath = [NamePathElem]

data NamedItemKind
    = NIKConstant
    | NIKVariable
    | NIKSignal
    | NIKFile
    | NIKAlias NamedItemKind
    deriving (Show, Eq, Ord)

niKindToString nik = case nik of
    NIKConstant -> "constant"
    NIKVariable -> "variable"
    NIKSignal -> "signal"
    NIKFile -> "file"
    NIKAlias anik -> niKindToString anik ++ " alias"

skipAliases (NIKAlias a) = skipAliases a
skipAliases n = n

{-
showRevPath = showRevPathG False
showRevPathForOldOsci = showRevPathG True

showRevPathG pointBeforeIndex = B.concat . tail . go . reverse . stripNPEIds
    where go [] = []
          go (NPELibrary i : xs) = p i xs
          go (NPEFile i : xs) = p i xs
                            --  ^ не совсем правильно, но в vir-е файлов нет
          go (NPEPackage i : xs) = p i xs
          go (NPEEntity  i : xs) = p i xs
          go (NPEProcess i : xs) = p i xs
          go (NPEFunction (-1) i : xs) = p i xs
          go (NPEFunction oi i : xs) = point : B.pack (show oi) : p i xs
          go (NPEType i : xs)    = p i xs
          go (NPEIdent _ i : xs) = p i xs
          go (NPEIndex i : xs)
              | pointBeforeIndex = point : s : go xs
              | otherwise = s : go xs
              where s = B.concat $ "(" : intersperse "," i ++ [")"]
          go (NPECIndex i : xs)
              | pointBeforeIndex = point : s : go xs
              | otherwise = s : go xs
              where s = B.concat $ "[" : intersperse "," i ++ ["]"]
          go (NPESlice i : xs)
              | pointBeforeIndex = point : s : go xs
              | otherwise = s : go xs
              where s = B.concat ["(", i, ")"]
          go (NPEField   i : xs) = p i xs
          go (NPEDeref : xs) = ".all" : go xs
          go (NPECDeref : xs) = "->" : go xs
                              --  ^ неправильно, т.к. может появиться ->->,
                              -- но showRevPath используется для отладки симулятора
                              -- и пользователю не показывается
          p i xs = point : fsToBs i : go xs
          point = "."

printRevPath rp = mapM_ p (reverse rp) >> putStrLn "."
    where p (NPELibrary i) = o 'L' i
          p (NPEFile i)    = o 'S' i
          p (NPEPackage i) = o 'P' i
          p (NPEEntity  i) = o 'E' i
          p (NPEProcess i) = o 'p' i
          p (NPEFunction oi i) = do
              putStrLn $ "f" ++ show oi
              hPutFS stdout i
              putStrLn ""
          p (NPEType i) = o 't' i
          p (NPEIdent k i) = do
              sk <- putAlias k
              o (head $ niKindToString sk) i
          p (NPEIndex i)   = do
              putStrLn $ "i" ++ show (length i)
              mapM_ B.putStrLn i
          p (NPECIndex i)  = do
              putStrLn $ "[" ++ show (length i)
              mapM_ B.putStrLn i
          p (NPESlice i)   = error "slice in osci??"
          p (NPEField i)   = o 'F' i
          p  NPEDeref      = putStrLn "d"
          p  NPECDeref     = putStrLn "*"
          p (NPEId i pe)   = do
              putStrLn "I"
              B.putStrLn i
              p pe
          o pref i = putStr [pref, ' '] >> hPutFS stdout i >> putStrLn ""
          putAlias (NIKAlias x) = putChar 'a' >> putAlias x
          putAlias a = return a
readRevPathG readLine = go []
    where go acc = p acc =<< readLine
          p acc s
              | s == "." = return acc
              | s == "d" = go (NPEDeref : acc)
              | s == "*" = go (NPECDeref : acc)
              | B.length s == 0 = error "Empty path element?"
              | B.index s 0 == 'i' = do
                  idxes <- replicateM (readInt $ B.tail s) readLine
                  go (NPEIndex idxes : acc)
              | B.index s 0 == '[' = do
                  idxes <- replicateM (readInt $ B.tail s) readLine
                  go (NPECIndex idxes : acc)
              | B.index s 0 == 'I' = do
                  id <- readLine
                  r <- go []
                  case reverse r of
                      [] -> error "No path element after id"
                      (pe:pes) -> return $ reverse (NPEId id pe : pes) ++ acc
              | B.index s 0 == 'f' = do
                  id <- readLine
                  go (NPEFunction (readInteger $ B.tail s) (bsToFs id) : acc)
              | B.index s 0 == 'a' = do
                  r <- p [] (B.drop 1 s)
                  case reverse r of
                      (NPEIdent k i : pes) ->
                          return $ reverse (NPEIdent (NIKAlias k) i : pes) ++ acc
                      _ -> err s
              | B.length s >= 2 && B.index s 1 == ' '
              , pref <- B.index s 0 = do
                  go ((case pref of
                      'L' -> NPELibrary
                      'S' -> NPEFile
                      'P' -> NPEPackage
                      'E' -> NPEEntity
                      'p' -> NPEProcess
                      't' -> NPEType
                      'F' -> NPEField
                      's' -> NPEIdent NIKSignal
                      'v' -> NPEIdent NIKVariable
                      'c' -> NPEIdent NIKConstant
                      _ -> err s)
                      (bsToFs $ B.drop 2 s)
                      : acc)
               | otherwise =
                   err s
          err s = error $ "Invalid path element line: " ++ B.unpack s
--           decodeAliases a s i
--               | i >= B.length s = err s
--               | otherwise = case B.index s i of
--                   's' -> NPEIdent (a NIKSignal) l
--                   'v' -> NPEIdent (a NIKVariable) l
--                   'c' -> NPEIdent (a NIKConstant) l
--                   'a' -> decodeAliases (NIKAlias . a) s (i+1)
--                   _ -> err s
--               where l = bsToFs $ B.drop (i+1) s
--           decode
-}


