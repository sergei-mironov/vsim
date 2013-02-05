{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleContexts, OverlappingInstances #-}

module Main where

import Control.Applicative
import Control.Exception
import Control.Monad
import Control.Monad.Trans
import Control.DeepSeq
import Control.DeepSeq.Generics (genericRnf)
import Data.Data
import Data.Typeable
import Data.List as List
import Data.Maybe
import Data.Text (Text)
import Data.Text.Lazy (unpack)
import Data.Time
import Data.Time.Calendar
-- import Happstack.Lite
import Happstack.Server
import Text.Printf
import Text.Highlighting.Kate as Kate
import Text.Blaze as B
import Text.Blaze.Html.Renderer.String (renderHtml)
import Text.Blaze.Html5 (Html, (!), a, form, input, p, toHtml, label)
import Text.Blaze.Html5.Attributes (action, enctype, href, name, size, type_, value)
import System.IO
import System.Directory
import System.Locale
import System.FilePath
import Prelude hiding (catch)
import GHC.Generics

import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

instance NFData LocalTime where rnf t = t`seq`()
instance NFData TestSet where rnf = genericRnf
instance NFData TestRecord where rnf = genericRnf

data Status = SOk | SError String
    deriving(Show, Data, Typeable)

type TestTime = Float

data TestRecord = TestRecord {
      tname :: String
    , trCode :: Maybe Int
    , vsimCode :: Maybe Int
    , ghcCode :: Maybe Int
    , binCode :: Maybe Int
    , binTime :: Maybe TestTime
    } deriving(Eq, Show, Generic)

instance Ord TestRecord where
    compare tr1 tr2 = (tname tr1) `compare` (tname tr2)

data TestSet = TestSet {
      rdir :: FilePath
    , rtime :: LocalTime
    , rpath :: FilePath
    , rtests :: [TestRecord]
    } deriving(Eq, Show, Generic)

rname tl = takeFileName $ rdir tl
rgit_id tl = drop 20 $ rname tl

instance Ord TestSet where
    compare l1 l2 = (rtime l1) `compare` (rtime l2)

zeroCode (Just 0) = True
zeroCode _ = False

passed fld l = foldl' cmp (0,0) l where
    cmp (c,t) r | zeroCode (fld r) = (c+1, t+1)
                | otherwise = (c, t+1)

catch' m = (do m >>= \a -> a `deepseq` (return (Just a))) `catch` err2nothing
    where err2nothing :: SomeException -> IO (Maybe a)
          err2nothing e = return Nothing

catch'' m = (do m >>= \a -> a `deepseq` (return (Just a))) `catch` err2nothing
    where err2nothing :: SomeException -> IO (Maybe a)
          err2nothing e = putStrLn (show e) >> return Nothing

loadLastWord :: FilePath -> IO String
loadLastWord fp = (last <$> words <$> readFile fp)

readLastWord :: (NFData a, Read a) => FilePath -> IO a
readLastWord fp = (read <$> loadLastWord fp)

loadTest :: FilePath -> IO (Maybe TestRecord)
loadTest drp = catch' $ do
    let rp = takeFileName drp
    let ll x = catch' (readLastWord (drp </> x))
    TestRecord <$> (loadLastWord (drp </> "NAME"))
               <*> ll "transl.log"
               <*> ll "vsim.log"
               <*> ll "ghc.log"
               <*> ll "binary.log"
               <*> ll "binary.time"

loadSet :: FilePath -> IO (Maybe TestSet)
loadSet drp = catch' $ do
    let rp = takeFileName drp
    TestSet <$> pure drp
             <*> pure (readTime defaultTimeLocale "%Y-%m-%d-%H-%M-%S" (take 19 rp))
             <*> pure drp
             <*> loadMany loadTest drp

loadMany :: (FilePath -> IO (Maybe a)) -> FilePath -> IO [a]
loadMany fn fp = do
    ls <- getDirectoryContents fp
    concat <$> map maybeToList <$> mapM fn (map (fp</>) ls)

loadSets = loadMany loadSet



template :: Text -> Html -> Response
template title body = toResponse $
  H.html $ do
    H.head $ do
      H.title (toHtml title)
    H.body $ do
      body
      p $ a ! href "/" $ "back home"

myApp :: ServerPart Response
myApp = table where

    root = "."

    for a b = map b a

    abs x = let t = "/" in t ++ (intercalate t x)

    setHref s = A.href (toValue $ abs [rname s])

    testHref s t = A.href (toValue $ abs [rname s, tname t])

    fileHref s t f = A.href (toValue $ abs [rname s, tname t, f])

    table = msum [
          path $ \s -> msum [
              path $ \t -> msum [
                    path (\f -> testFile s t f)
                  , testIndex s t
                ]
            , setIndex s
            ]
        , mainIndex
        ]

    mainIndex = do
        sets <- liftIO $ loadSets root
        ok $ template "home page" $ do
            H.h1 "VSim"
            H.table $ sequence_ $ for sets $ \s -> do
                let stat x = show $ passed x (rtests s)
                H.tr $ do
                    H.td $ H.a ! setHref s $ H.toHtml (rgit_id s)
                    H.td $ H.toHtml $ show $ rtime s
                    H.td $ H.toHtml $ stat trCode
                    H.td $ H.toHtml $ stat vsimCode
                    H.td $ H.toHtml $ stat ghcCode
                    H.td $ H.toHtml $ stat binCode

    testIndex s t = do
        (Just t) <- liftIO $ loadTest (root</>s</>t)
        ok $ template "VSim details" $ do
            H.h1 $ H.toHtml (tname t)

    setIndex s = do
        (Just s) <- liftIO $ loadSet (root</>s)
        ok $ template "VSim details" $ do
            H.table $ sequence_ $ for (rtests s) $ \t -> do
                H.tr $ do
                    H.td $ H.a ! testHref s t $ H.toHtml (tname t)

    testFile s t f = do
        code <- liftIO $ readFile (root </> s </> t </> f)
        let ftype = case takeExtension f of
                    ".hs" -> "haskell"
                    ".vir" -> "commonlisp"
                    _ -> "text"
        ok $ template "Listing" $ do
                H.head $ H.style ! A.type_ (toValue ("text/css" :: String))
                       $ toHtml $ styleToCss tango
                H.body $ toHtml
                       $ formatHtmlBlock defaultFormatOpts
                       $ highlightAs ftype code

main :: IO ()
main = simpleHTTP nullConf myApp

