{-# LANGUAGE OverloadedStrings #-}
import Control.Applicative ((<$>))
import Control.Monad
import Data.Monoid ((<>), mconcat)
import Data.Function
import Data.List
import qualified Data.Text as T
import Hakyll

type Author = String
type Year   = String
type Spark  = String

thisYear = "2015"

imagesEtc = foldr1 (.||.)
    [ "images/*.png"
    , "images/*.svg"
    , "images/*.ico"
    , "fonts/*"
    , "downloads/*"
    , "email/key.asc"
    ]

main :: IO ()
main = hakyllWith config $ do

    match imagesEtc $ do
        route idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route idRoute
        compile compressCssCompiler

    match "templates/*" $ compile templateCompiler

    match "index.md" $ do
        route $ setExtension "html"
        compile'

    match "code.md" $ do
        route $ constRoute "code/index.html"
        compile'

    match "src/*/index.html" $ do
        route idRoute
        compile copyFileCompiler

    match "cv.md" $ do
        route $ constRoute "cv/index.html"
        compile'

    match "email.md" $ do
        route $ constRoute "email/index.html"
        compile'

    match "papers/*.md" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/paper.html" defaultContext
            >>= saveSnapshot "papers"
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    create ["papers/index.html"] $ do
       route idRoute
       compile $ do
           ps <- recentFirst =<< loadAllSnapshots "papers/*.md" "papers"
           r  <- publicationRecord
           let context = mconcat
                   [ constField "papers" (ps >>= itemBody)
                   , constField "spark" r
                   , constField "title" "akc.is/papers - Anders Claesson's papers"
                   , constField "id" "papers"
                   , defaultContext
                   ]
           makeItem ""
               >>= loadAndApplyTemplate "templates/papers.html" context
               >>= loadAndApplyTemplate "templates/default.html" context
               >>= relativizeUrls

    create ["coauthors/index.html"] $ do
        route idRoute
        compile $ do
            let context = mconcat
                    [ listField "coauthors" defaultContext coauthors
                    , constField "title" "akc.is/coauthors - Anders Claesson's coauthors"
                    , constField "id" "coauthors"
                    , defaultContext
                    ]
            makeItem ""
                >>= loadAndApplyTemplate "templates/coauthors.html" context
                >>= loadAndApplyTemplate "templates/default.html" context
                >>= relativizeUrls

    create ["papers/feed.atom"] $ do
        route idRoute
        compile $ do
            let context = bodyField "description" <> defaultContext
            ps <- fmap (take 10) . recentFirst =<< loadAllSnapshots "papers/*.md" "papers"
            renderAtom papersFeedConfiguration context ps

config :: Configuration
config = defaultConfiguration
    { deployCommand = unlines
       [ "rsync -av --delete _site/* ../akc.github.io"
       , "cd ../akc.github.io"
       , "git add -A"
       , "msg=\"Deployed: \"`date`"
       , "echo \">>> \"$msg"
       , "git commit -m \"$msg\""
       , "git push -f"
       , "cd -"
       ]
    }

papersFeedConfiguration :: FeedConfiguration
papersFeedConfiguration = FeedConfiguration
    { feedTitle       = "akc.is/papers"
    , feedDescription = "Papers and preprints by Anders Claesson (akc)"
    , feedAuthorName  = "Anders Claesson"
    , feedAuthorEmail = "anders.claesson@strath.ac.uk"
    , feedRoot        = "http://akc.is"
    }

-- Split string on commas
split :: String -> [String]
split = map (T.unpack . T.strip) . T.splitOn "," . T.pack

getAuthors :: Item String -> Compiler [Author]
getAuthors item = split <$> getMetadataField' (itemIdentifier item) "authors"

getYear :: Item String -> Compiler Year
getYear item = getMetadataField' (itemIdentifier item) "year"

getAuthorYear :: Item String -> Compiler [(Author, Year)]
getAuthorYear item = do
    as <- getAuthors item
    y  <- getYear item
    return [ (a,y) | a<-as ]

coauthors :: Compiler [Item String]
coauthors = do
    ps <- loadAll "papers/*.md"
    tpl <- loadBody "templates/coauthor.html"
    let f = map unzip . groupBy ((==) `on` fst) . sort . concat
    xs <- f <$> mapM getAuthorYear ps
    let rankedMax ys = (-length ys, sort (map ((*(-1)) . read) ys))
    let ays = tail . map snd $ sort [ (rankedMax ys, (a,ys)) | (a:_, ys) <- xs ]
    let largest = maximum $ ays >>= yearDistribution' . snd
    forM ays $ \(a,ys) -> do
        let years   = intercalate ", " $ nub ys
        let sprk    = spark largest $ tail (yearDistribution' ys)
        let context = mconcat
                [ constField "coauthor" a
                , constField "years" years
                , constField "spark" sprk
                ]
        makeItem "" >>= applyTemplate tpl context

mostPublished :: Compiler Double
mostPublished = do
    ps <- loadAll "papers/*.md"
    ys <- mapM getYear ps
    return . maximum $ yearDistribution' ys

publicationRecord :: Compiler Spark
publicationRecord = do
    ps <- loadAll "papers/*.md"
    ys <- mapM getYear ps
    m  <- mostPublished
    return . spark m $ yearDistribution' ys

compile' =
    compile $ pandocCompiler
        >>= loadAndApplyTemplate "templates/default.html" defaultContext
        >>= relativizeUrls

-- This function is due to Chao Xu. See
-- https://github.com/Mgccl/mgccl-haskell/blob/master/random/spark.hs
spark :: Double -> [Double] -> Spark
spark largest list = map ("▁▂▃▄▅▆▇" !!) xs
  where
    zs = map (flip (-) (minimum list)) list
    xs = map (round . (* 6) . (/ largest)) zs

runLengths :: (Eq a, Num b) => [a] -> [b]
runLengths = map (fromIntegral . length) . group

yearDistribution :: (Num b) => [Int] -> [b]
yearDistribution = map (+(-1)) . runLengths . sort . ([2001..read thisYear] ++ )

yearDistribution' :: (Num b) => [String] -> [b]
yearDistribution' = yearDistribution . map read
