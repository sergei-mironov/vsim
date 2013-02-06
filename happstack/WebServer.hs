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
import Data.Char
import Data.List as List
import Data.Maybe
import Data.Monoid
import Data.Text (Text)
import Data.Text.Lazy (unpack)
import Data.Time
import Data.Time.Calendar
import Happstack.Server
import Text.Highlighting.Kate as Kate
import Text.Printf
import Text.Blaze as B
import Text.Blaze.Html.Renderer.String (renderHtml)
import Text.Blaze.Html5 (Html, (!), a, form, input, p, toHtml, label, div, table, td, tr)
import Text.Blaze.Html5.Attributes (action, enctype, href, name, size, type_, value, class_)
import System.IO
import System.Directory
import System.Locale
import System.FilePath
import Prelude hiding (catch,div)
import GHC.Generics

import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

instance NFData LocalTime where rnf t = t`seq`()
instance NFData TestSet where rnf = genericRnf
instance NFData TestRecord where rnf = genericRnf

data Status = SOk | SError String
    deriving(Show)

type TestTime = Float

data TestRecord = TestRecord {
      tname :: String
    , tdir :: FilePath
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

loadLastWord fp = (last <$> words <$> readFile fp)
readLastWord fp = (read <$> loadLastWord fp)

loadTest :: FilePath -> IO (Maybe TestRecord)
loadTest drp = catch' $ do
    let rp = takeFileName drp
    let ll x = catch' (readLastWord (drp </> x))
    TestRecord <$> (loadLastWord (drp </> "NAME"))
               <*> (pure drp)
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
             <*> (sort <$> loadMany loadTest drp)

loadMany :: (FilePath -> IO (Maybe a)) -> FilePath -> IO [a]
loadMany fn fp = do
    ls <- getDirectoryContents fp
    concat <$> map maybeToList <$> mapM fn (map (fp</>) ls)

loadSets = loadMany loadSet

loadFiles fs = map takeFileName <$> loadMany (\f -> do
    doesFileExist f >>= \b -> if b then return (Just f) else return Nothing) fs

myApp :: ServerPart Response
myApp = table where

    css = "happstack"
    root = "history"
    for a b = map b a
    abs x = let t = "/" in t ++ (intercalate t x)
    setHref s = A.href (toValue $ abs [rname s])
    testHref s t = A.href (toValue $ abs [rname s, tname t])
    fileHref s t f = A.href (toValue $ abs [rname s, tname t, f])

    aBtn = a ! class_ "bttn"
    aBtnSmall = a ! class_ "bttn-small"
    aAsis = a ! class_ "asis"
    div'row = div ! class_ "row"

    ftype ".hs"  = "haskell"
    ftype ".vir" = "commonlisp"
    ftype _      = "text"

    srcs fs = filter (\f->elem (takeExtension f) [".vir",".hs", ".vhd"]) fs

    logs fs = let logs1 = filter (flip elem fs) [
                    "transl.log","vsim.log", "ghc.log", "binary.log"]
                  logs2 = filter (\f->elem (takeExtension f) [".log"]) fs
              in logs1 ++ (filter (not . flip elem logs1) logs2)

    almostall fs = let logs1 = filter (flip elem fs) [
                         "transl.log","transl.vir", "vsim.log",
                         "sim.hs", "ghc.log", "binary.log"]
                       logs2 = filter (\f->elem (takeExtension f) [".log"]) fs
                       bads = ["DATE", "NAME"]
                   in filter (not . flip elem bads) $
                        logs1 ++ (filter (not . flip elem logs1) logs2)

    table = msum [
          dir "css" $ path $ \f -> do
            serveFile (guessContentTypeM mimeTypes) (css</>f)
        , path $ \s -> do
            (Just s) <- liftIO $ loadSet (root</>s)
            msum [
                  path $ \t -> do
                    (Just t) <- liftIO $ loadTest ((rdir s)</>t)
                    msum [
                        dir "alllogs" $ testIndexLogs s t
                      , path (\f -> testFile s t f)
                      , testIndex s t
                      ]
                , setIndex s
                ]
        , mainIndex
        ]

    headers title = do
        H.head $ do
            H.title title
            H.meta ! (A.httpEquiv "X-UA-Compatible")
                   ! (A.content "IE=EmulateIE7; IE=EmulateIE9")
            H.meta ! (A.httpEquiv "Content-Type")
                   ! (A.content "text/html; charset=utf-8")

            H.meta ! (A.name "viewport")
                   ! (A.content $ toValue (concat [
                        "width=device-width, initial-scale=1.0, ",
                        "maximum-scale=1.0, user-scalable=no"] :: String))
            H.link ! A.rel "stylesheet" ! A.href "/css/base.css"
                 ! A.type_ "text/css" ! A.media "all"
            H.link ! A.rel "stylesheet" ! A.href "/css/720_grid.css"
                 ! A.type_ "text/css" ! A.media "screen and (min-width: 720px)"
            H.link ! A.rel "stylesheet" ! A.href "/css/986_grid.css"
                 ! A.type_ "text/css" ! A.media "screen and (min-width: 986px)"
            H.link ! A.rel "stylesheet" ! A.href "/css/1236_grid.css"
                 ! A.media "screen and (min-width: 1236px)"
            H.script ! A.type_ "text/javascript" $ "try{Typekit.load();}catch(e){}"

            H.style ! (A.type_ "text/css") $ do
                toHtml $ styleToCss tango

    template title body = toResponse $ do
        H.html $ do
            headers title
            H.body $ do
                H.div ! class_ "grid" $ do
                    div ! class_ "row" $ do
                        div ! class_ "slot-6" $ H.p $ ""
                        div ! class_ "slot-7-8" $ do
                            div'row $ H.h1 "VSim"
                            div'row $ body
                            div'row $ aBtn ! href "/" $ "Home"
                        div ! class_ "slot-9" $ H.p $ ""

    template5 title body = toResponse $ do
        H.html $ do
            headers title
            H.body $ do
                H.div ! class_ "grid" $ do
                    div ! class_ "row" $ do
                        div ! class_ "slot-0-1-2-3-4-5" $ do
                            div'row $ H.h1 "VSim"
                            div'row $ body
                            div'row $ aBtn ! href "/" $ "Home"

    mainIndex = do
        sets <- liftIO $ sort <$> loadSets root
        ok $ template "home page" $ do
            H.table $ sequence_ $ for sets $ \s -> do
                let stat x = show $ passed x (rtests s)
                H.tr $ do
                    H.td $ H.a ! setHref s $ H.toHtml (rgit_id s)
                    H.td $ H.toHtml $ show $ rtime s
                    H.td $ H.toHtml $ stat trCode
                    H.td $ H.toHtml $ stat vsimCode
                    H.td $ H.toHtml $ stat ghcCode
                    H.td $ H.toHtml $ stat binCode
    
    testStatus t
        | trCode t /= (Just 0) = H.span ! A.class_ "failed-tr" $ "[TR]"
        | vsimCode t /= (Just 0) = H.span ! A.class_ "failed-vsim" $ "[VSIM]"
        | ghcCode t /= (Just 0) = H.span ! A.class_ "failed-ghc" $ "[GHC]"
        | binCode t /= (Just 0) = H.span ! A.class_ "failed-bin" $ "[BIN]"
        | binTime t == Nothing = H.span ! A.class_ "failed-bin" $ "No time data"
        | otherwise = H.span ! A.class_ "ok" $ toHtml $ "[" ++ (show $ fromJust (binTime t)) ++ "]"
        
    hasTime t | binTime t /= Nothing = True
              | otherwise = False

    str :: String -> String
    str = id

    setIndex s = do
        ok $ template "VSim details" $ do
            aBtn ! href "/" $ "Up"
            let table ls = H.table ! A.class_ "set" $ sequence_ $ for ls $ \t -> do
                            H.tr $ do
                                H.td ! class_ "details-name" $ aAsis ! testHref s t $
                                    H.toHtml (tname t)
                                H.td ! class_ "details-status"  $ aAsis ! testHref s t $
                                    testStatus t
            let failed = filter (not.hasTime) (rtests s)
            H.h2 $ toHtml $ str $ printf "Failed (%d/%d)" (length failed) (length (rtests s))
            table failed
            let passed = filter hasTime (rtests s)
            H.h2 $ toHtml $ str $ printf "Passed (%d/%d)" (length passed) (length (rtests s))
            table passed

    capitilize s = let c = head s in toUpper c : tail s

    testIndex s t = do
        fs <- liftIO $ sort <$> loadFiles (tdir t)
        ok $ template "VSim details" $ do
            div'row $ do
                aBtn ! setHref s $ "Up"
            div'row $ do
                div ! class_ "slot-7-8" $ do
                    H.h2 $ aAsis ! fileHref s t "alllogs" $
                        H.toHtml $ (capitilize $ tname t) ++ " >"
                    H.h3 $ "Status"
                    H.table $ do
                        tr $ do
                            td "Translator"
                            td $ toHtml $ (show (trCode t))
                        tr $ do
                            td "VSim"
                            td $ toHtml $ (show (vsimCode t))
                        tr $ do
                            td "GHC"
                            td $ toHtml $ (show (ghcCode t))
                        tr $ do
                            td "Binary"
                            td $ toHtml $ (show (binCode t))
            div'row $ do
                let ftable fs = 
                        H.table $ do
                            sequence_ $ for fs $ \f -> do
                                H.tr $ H.td $ H.a ! fileHref s t (takeFileName f) $
                                    H.toHtml (takeFileName f)
                div ! class_ "slot-7" $ do
                    H.h3 $ aAsis ! fileHref s t "alllogs" $ "Sources >"
                    ftable (srcs fs)
                    H.h3 $ aAsis ! fileHref s t "alllogs" $ "Logs >"
                    ftable (logs fs)
                div ! class_ "slot-8" $ do
                    H.h3 $ aAsis ! fileHref s t "alllogs" $ "All >"
                    ftable fs

    testIndexLogs s t = do
        fs <- liftIO $ sort <$> loadFiles (tdir t)
        fs' <- forM (almostall fs) $ \f -> do
            code <- liftIO $ readFile ((tdir t) </> f)
            let html = toHtml $ do
                            formatHtmlBlock defaultFormatOpts $
                                highlightAs (ftype (takeExtension f)) code
            return (takeFileName f, html)
        ok $ template5 "VSim details" $ do
            aBtn ! testHref s t $ "Up"
            div'row $ do
                sequence_ $ for fs' $ \(n,html) -> do
                    H.h3 $ toHtml n
                    html

    testFile s t f = do
        code <- liftIO $ readFile ((tdir t)</>f)
        ok $ template5 "Listing" $ do
            aBtn ! testHref s t $ "Up"
            toHtml $ do
                formatHtmlBlock defaultFormatOpts $
                    highlightAs (ftype (takeExtension f)) code

main :: IO ()
main = simpleHTTP nullConf myApp

