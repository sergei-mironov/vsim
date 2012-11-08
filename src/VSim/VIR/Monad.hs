{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE DeriveDataTypeable #-}

module VSim.VIR.Monad (
      ParserState(..)
    , Parser(..)
    , ParserError(..)
    , runParser
    , newState
    , formatErr
    , lexer
    , parseError
    , getLoc
    ) where

import Data.ByteString.Char8 as B
import Data.List
import Data.Ord
import Data.IORef
import Data.IORefEx
import Data.Maybe
import Data.Typeable
import Data.Time.Clock

import Control.Applicative
import Control.Monad
import Control.Monad.Fix
import Control.Monad.Reader
import Control.Monad.Error
import Control.Monad.State
import Control.Exception as E

import System.FilePath
import System.IO.Error
import System.IO

import Text.Printf

import VSim.Data.Loc
import VSim.Data.Line
import VSim.VIR.Types
import VSim.VIR.Lexer as L

data ParserState = ParserState {
      psFileName :: FilePath
    , psInput :: IORef L.AlexInput
    , psTokenStart :: IORef Int
    , psPrevTokenEnd :: IORef Int
    , psLocationStack :: IORef [Line]
    }

newtype Parser a = Parser { unParser :: ReaderT ParserState IO a }
    deriving (
        Functor,
        MonadReader ParserState,
        MonadIO,
        MonadFix,
        Monad )

runParser :: ParserState -> Parser a -> IO a
runParser ps p = runReaderT (unParser p) ps

data ParserError = ParserError String
    deriving (Show, Typeable)

instance E.Exception ParserError

instance MonadError ParserError Parser where
    throwError e = Parser $ E.throw e
    catchError p f =
        Parser $ ReaderT $ \ps -> do
            e <- tryS $ runReaderT (unParser p) ps
            either (\e -> runReaderT (unParser $ f $ ParserError e) ps)
                   return e

tryS :: IO a -> IO (Either String a)
tryS act =
    E.handle (\(e :: E.SomeException) -> retE $ show e) $
    E.handle (\(ParserError e) -> return $ Left e) $
    E.handle (\(e) -> retE $ ioeGetErrorString e) $
    fmap Right act
    where retE = return . Left . formatErr unknownLoc

getLoc :: Parser Loc
getLoc = do
    (l, ec) <- fmap L.irScanLineColumn (readRef psInput)
    sc <- readRef psTokenStart
    ls <- readRef psLocationStack
    fn <- asks psFileName
    let r = Loc (case ls of [] -> Nothing; (x:_) -> x `seq` Just x)
                l sc ec fn
    r `seq` return r

lexer :: (L.Token -> Parser b) -> Parser b
lexer f = do
    writeRef psPrevTokenEnd =<< fmap (snd . L.irScanLineColumn) (readRef psInput)
    (startColumn, tok) <- L.irScanM (readRef psInput) (writeRef psInput)
    writeRef psTokenStart startColumn
    f tok

newState :: String -> B.ByteString -> IO ParserState
newState fn inp = do
    let psFileName = fn
    psInput <- newIORef (L.newIrScanInput inp)
    psTokenStart <- newIORef 0
    psPrevTokenEnd <- newIORef 0
    psLocationStack <- newIORef []
    return $ ParserState {..}

parseError :: (Show t) => t -> Parser a
parseError token = do
    loc <- getLoc
    fail $ formatErr loc $ "Parse error on token " ++ (show token)

formatErr :: Loc -> String -> String
formatErr (Loc sl l sc ec fn) err =
    printf "File %s, line %s, characters %s-%s:%s %s\n"
        (show fn) (show l) (show sc) (show $ ec-1) (unl sl) err
    where 
        unl (Just l) = showLine l
        unl Nothing = "_:0:0:"

