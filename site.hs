{-# LANGUAGE OverloadedStrings #-}
import Control.Applicative ((<$>))
import Control.Monad
import Data.Monoid ((<>))
import Data.Function
import Data.List
import qualified Data.Text as T
import Hakyll

main :: IO ()
main = hakyll $ do
  match ("images/*.png" .||. "images/*.ico" .||. "fonts/*") $ do
    route idRoute
    compile copyFileCompiler

  match "css/*" $ do
    route idRoute
    compile compressCssCompiler

  match "templates/*" $ compile templateCompiler

  match "index.md" $ do
     route $ setExtension "html"
     compile'

  match "teaching.md" $ do
     route $ constRoute "teaching/index.html"
     compile'

  match "cv.md" $ do
     route $ constRoute "cv/index.html"
     compile'

  match "papers/*.md" $ compile $ pandocCompiler

  create ["papers/index.html"] $ do
     route idRoute
     compile $ do
       p <- papers
       s <- publicationRecord
       let ctx = constField "papers" p <> defaultContext
       makeItem ""
          >>= loadAndApplyTemplate "templates/papers.html" ctx
          >>= loadAndApplyTemplate "templates/default.html" defaultContext
          >>= relativizeUrls

  create ["coauthors/index.html"] $ do
     route idRoute
     compile $ do
       let ctx = listField "coauthors" defaultContext coauthors
       makeItem ""
          >>= loadAndApplyTemplate "templates/coauthors.html" ctx
          >>= loadAndApplyTemplate "templates/default.html" defaultContext
          >>= relativizeUrls

papers :: Compiler String
papers = do
  tpl <- loadBody "templates/paper.html"
  ps  <- recentFirst =<< loadAll "papers/*.md"
  applyTemplateList tpl defaultContext ps

-- Split string on commas
split :: String -> [String]
split s = map (T.unpack . T.strip) $ T.splitOn (T.pack ",") (T.pack s)

getAuthors :: Item String -> Compiler [String]
getAuthors item = split `fmap` getMetadataField' (itemIdentifier item) "authors"

getYear :: Item String -> Compiler String
getYear item = getMetadataField' (itemIdentifier item) "year"

getAuthorYear :: Item String -> Compiler [(String, String)]
getAuthorYear item = do
  as <- getAuthors item
  y  <- getYear item
  return [ (a,y) | a<-as ]

coauthors :: Compiler [Item String]
coauthors = do
  ps  <- loadAll "papers/*.md"
  xs  <- mapM getAuthorYear ps
  tpl <- loadBody "templates/coauthor.html"
  let zss = map unzip $ groupBy ((==) `on` fst) $ sort $ concat xs
  let zss' = tail
             $ map snd
             $ sort [ ((-length ys, -(maximum $ map read ys)), (a,ys)) | (a:_, ys) <- zss ]
  forM  zss' $ \(a,ys) -> do
      let ys' = map read ys
      let years = concat $ intersperse ", " $ nub ys
      let ctx = constField "coauthor" a  <> 
                constField "years" years <>
                constField "spark" (spark (map fromIntegral $ tail $ yearDistribution ys'))
      makeItem "" >>= applyTemplate tpl ctx

publicationRecord :: Compiler String
publicationRecord = do
  ps <- loadAll "papers/*.md"
  ys <- mapM getYear ps
  return . spark . map fromIntegral . yearDistribution $ map read ys

compile' =
   compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" defaultContext
      >>= relativizeUrls

-- Stolen from https://github.com/Mgccl/mgccl-haskell/blob/master/random/spark.hs
spark :: [Double] -> String
spark list = map ("▁▂▃▄▅▆▇" !!) xs
    where zs = map (flip (-) (minimum list)) list
          xs = map (round . (* 6) . (/ maximum zs)) zs

runLengths :: Eq a => [a] -> [Int]
runLengths = map length . group

yearDistribution :: [Int] -> [Int]
yearDistribution ys = map (+(-1)) . runLengths . sort $ ys ++ [2001..2013]
