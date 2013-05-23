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
import System.Environment
import System.Exit
import Prelude hiding (catch,div)
import GHC.Generics

import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

-- instance NFData LocalTime where rnf t = t`seq`()
instance NFData TestSet where rnf = genericRnf
instance NFData TestRecord where rnf = genericRnf

data Status = SOk | SError String
    deriving(Show)

type TestTime = Float

data TestRecord = TestRecord {
      tNAME :: String
    , tdir :: FilePath
    , trCode :: (String, Maybe Int)
    , vsimCode :: (String, Maybe Int)
    , ghcCode :: (String, Maybe Int)
    , binCode :: (String, Maybe Int)
    , binTime :: Maybe TestTime
    } deriving(Eq, Show, Generic)

tname = takeFileName . tdir

instance Ord TestRecord where
    compare tr1 tr2 = (tname tr1) `compare` (tname tr2)

hasTime t | (binTime t) /= Nothing = True
          | otherwise = False

passed = hasTime

data TestSet = TestSet {
      rdir :: FilePath
    , rtime :: LocalTime
    , rpath :: FilePath
    , rtests :: [TestRecord]
    } deriving(Eq, Show, Generic)

filter_failes s = filter (not . hasTime) (rtests s)

filter_passed s = filter hasTime (rtests s)

count_changes s s' = (length $ filter_passed s') - (length $ filter_passed s)

slice_by_name ss n = filter (not.null.fst) $ (map (filter ((==n).tname).rtests) ss) `zip` ss

find_test s n = listToMaybe $ filter ((==n) . tname) $ rtests s

find_set ss n = listToMaybe $ filter ((==n) . rname) ss

rname = takeFileName . rdir

rgit_id tl = drop 20 $ rname tl

instance Ord TestSet where
    compare l1 l2 = (rtime l1) `compare` (rtime l2)

zeroCode (Just 0) = True
zeroCode _ = False

catch' m = (do m >>= \a -> a `deepseq` (return (Just a))) `catch` err2nothing
    where err2nothing :: SomeException -> IO (Maybe a)
          err2nothing e = return Nothing

loadLastWord fp = (last <$> words <$> readFile fp)
readLastWord fp = (read <$> loadLastWord fp)

loadTest :: FilePath -> IO (Maybe TestRecord)
loadTest drp = catch' $ do
    let rp = takeFileName drp
    let ll x = catch' (readLastWord (drp </> x))
    let lc x = (\c->(x,c)) <$> catch' (readLastWord (drp </> x))
    TestRecord <$> (loadLastWord (drp </> "NAME"))
               <*> (pure drp)
               <*> lc "transl.log"
               <*> lc "vsim.log"
               <*> lc "ghc.log"
               <*> lc "binary.log"
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

myApp :: String -> ServerPart Response
myApp d = table where

    alllogs = "alllogs"
    root = d</>"history"
    css = d</>"happstack"
    for a b = map b a
    abs x = let t = "/" in t ++ (intercalate t x)
    setHref s = A.href (toValue $ abs [rname s])
    testHref s t = A.href (toValue $ abs [rname s, tname t])
    fileHref s t f = A.href (toValue $ abs [rname s, tname t, alllogs ++ "#" ++ f])
    anchored e x = (e ! (A.name x) ! (A.id x))

    aSelect = a ! class_ "selected"
    aBtn = a ! class_ "bttn"
    aBtnSmall = a ! class_ "bttn-small"
    aAsis = a ! class_ "asis"
    div'row = div ! class_ "row"

    ftype ".hs"  = "haskell"
    ftype ".vhd"  = "vhdl"
    ftype ".vir" = "commonlisp"
    ftype _      = "text"

    srcs fs = filter (\f->elem (takeExtension f) [".vhd"]) fs

    logs fs = let logs1 = filter (flip elem fs) [
                    "transl.log","vsim.log", "ghc.log", "binary.log"]
                  logs2 = filter (\f->elem (takeExtension f) [".log"]) fs
              in logs1 ++ (filter (not . flip elem logs1) logs2)

    almostall fs = let logs1 = filter (flip elem fs) [
                         "source.vhd", "transl.log","transl.vir", "vsim.log",
                         "sim.hs", "ghc.log", "binary.log"]
                       logs2 = filter (\f->elem (takeExtension f) [".log"]) fs
                       bads = ["DATE", "NAME"]
                   in filter (not . flip elem bads) $
                        logs1 ++ (filter (not . flip elem logs1) logs2)

    table = msum [
          dir "css" $ path $ \f -> do
            serveFile (guessContentTypeM mimeTypes) (css</>f)
        , do 
            ss <- liftIO $ (reverse . sort) <$> loadSets root
            msum [
                  path $ \sn -> do
                    let s = case find_set ss sn of
                                Just s -> s
                                Nothing -> error sn
                    msum [
                          path $ \tn -> do
                            let t = case find_test s tn of
                                        Just t -> t
                                        Nothing -> error (sn</>tn)
                            msum [
                                dir "alllogs" $ testIndexLogs s t
                              , path (\f -> testFile ss s t f)
                              , testIndex ss s t
                              ]
                        , setIndex ss s
                        ]
                , mainIndex ss
                ]
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
                    div'row $ do
                        div ! class_ "slot-6" $ H.p mempty
                        div ! class_ "slot-7-8" $ do
                            div'row $ H.h1 $ aAsis ! href "/" $ "VSim"
                            div'row $ body
                            div'row $ aBtn ! href "/" $ "Home"
                        div ! class_ "slot-9" $ H.p $ ""
                    div'row $ do
                        div ! class_ "slot-6" $ H.p mempty
                        div ! class_ "slot-7-8" $ do
                            H.footer ! class_ "footer" $ do
                                H.span $ "Powered by "
                                a ! href "http://happstack.com" $ "Happstack7"

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

    mainIndex ss = do
        let sp | length ss > 0 = ((map Just $ tail ss)++(repeat Nothing)) `zip` ss
               | otherwise = []
        ok $ template "home page" $ do
            H.table $ sequence_ $ for sp $ \(s_prev,s) -> do
                H.tr $ do
                    H.td $ H.a ! setHref s $ H.toHtml (rgit_id s)
                    H.td $ H.toHtml $ show (rtime s)
                    H.td $ H.toHtml $ str $ printf "%d/%d"
                        (length $ filter_passed s)
                        (length $ rtests s)
                    let render_changes x
                         | x >= 0 = H.span ! class_ "changes_ge0" $ H.toHtml $ '+' : show x
                         | otherwise = H.span ! class_ "changes_l0" $ H.toHtml $ show x  
                    case s_prev of
                        Just sp -> H.td $ H.toHtml $ render_changes $ count_changes sp s
                        _       -> H.td $ mempty
    
    testStatus s t@(TestRecord _ _ (tr,trc) (vs,vsc) (g,gc) (b,bc) _ )
        | trc /= (Just 0) = lnk "failed-tr" tr "[TR]"
        | vsc /= (Just 0) = lnk "failed-vsim" vs "[VSIM]"
        | gc /= (Just 0) = lnk "failed-ghc" g "[GHC]"
        | bc /= (Just 0) = lnk "failed-bin" b "[BIN]"
        | (binTime t) == Nothing = lnk "failed-bin" "" "[?]"
        | otherwise = lnk "ok" "" $ toHtml $
            "[" ++ (show $ fromJust (binTime t)) ++ "]"
        where lnk c f txt = a ! class_ (toValue $ str c) ! fileHref s t f $ txt
        
    str :: String -> String
    str = id

    setIndex _ s = do
        ok $ template "VSim details" $ do
            H.p $ toHtml $ rname s
            aBtn ! href "/" $ "Up"
            let table ls = H.table ! A.class_ "set" $ sequence_ $ for ls $ \t -> do
                            H.tr $ do
                                H.td ! class_ "details-name" $ aAsis ! testHref s t $
                                    H.toHtml (tname t)
                                H.td ! class_ "details-status"  $ testStatus s t
            let fs = filter_failes s
            H.h2 $ toHtml $ str $ printf "Failed (%d/%d)" (length fs) (length (rtests s))
            table fs
            let ps = filter_passed s
            H.h2 $ toHtml $ str $ printf "Passed (%d/%d)" (length ps) (length (rtests s))
            table ps

    capitilize s = let c = head s in toUpper c : tail s

    testIndex ss s t = do
        let comment ('-':'-':' ':_) = True
            comment _ = False
        jtxt <- liftIO $ catch' $ do
            takeWhile comment <$> lines <$> readFile ((tdir t)</>"source.vhd")
        fs <- liftIO $ sort <$> loadFiles (tdir t)
        let oldies = slice_by_name ss (tname t)
        ok $ template "VSim details" $ do
            div'row $ do
                H.p $ toHtml $ rname s
                aBtn ! setHref s $ "Up"
            div'row $ do
                div ! class_ "slot-7-8" $ do
                    H.h2 $ aAsis ! fileHref s t alllogs $
                        H.toHtml $ (capitilize $ tname t)
                    case jtxt of
                            Just txt -> do
                                sequence_ $ for txt $ \l -> do
                                    H.p $ toHtml (drop 3 l)
                            _ -> H.p "no description"
                    H.h3 $ "Status"
                    toHtml $ str "Test status: "
                    testStatus s t
            div'row $ do
                let ftable fs = 
                        H.table $ do
                            sequence_ $ for fs $ \f -> do
                                H.tr $ H.td $ H.a ! fileHref s t (takeFileName f) $
                                    H.toHtml (takeFileName f)
                div ! class_ "slot-7" $ do
                    H.h3 $ aAsis ! fileHref s t alllogs $ "Sources >"
                    ftable (srcs fs)
                    H.h3 $ aAsis ! fileHref s t alllogs $ "Logs >"
                    ftable (logs fs)
                div ! class_ "slot-8" $ do
                    H.h3 $  "Others"
                    H.hr
                    H.table $ do
                        sequence_ $ for oldies $ \ ([t],s') -> do
                            H.tr $ do
                                let a = if s == s' then aSelect else H.a
                                H.td $ a ! testHref s' t $ H.toHtml $ rgit_id s'
                                H.td $ testStatus s' t

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
                    H.h3 `anchored`(H.toValue n) $ toHtml n
                    html

    testFile _ s t f = do
        code <- liftIO $ readFile ((tdir t)</>f)
        ok $ template5 "Listing" $ do
            aBtn ! testHref s t $ "Up"
            toHtml $ do
                formatHtmlBlock defaultFormatOpts $
                    highlightAs (ftype (takeExtension f)) code

exit x = do
    hPutStrLn stderr $ "WebServer: " ++ x
    exitFailure

main_ (d:_) = simpleHTTP nullConf (myApp d)
main_ _ = exit "One argument required"

main :: IO ()
main = getArgs >>= main_
