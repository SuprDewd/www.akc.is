{-# LANGUAGE OverloadedStrings #-}
import Control.Applicative ((<$>))
import Data.Monoid ((<>), mconcat)
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
       let ctx = constField "papers" p <> defaultContext
       makeItem ""
          >>= loadAndApplyTemplate "templates/papers.html" ctx
          >>= loadAndApplyTemplate "templates/default.html" defaultContext
          >>= relativizeUrls

  create ["coauthors/index.html"] $ do
     route idRoute
     compile $ do
       let ctx = listField "coauthors" defaultContext coauthors <> defaultContext
       makeItem ""
          >>= loadAndApplyTemplate "templates/coauthors.html" ctx
          >>= loadAndApplyTemplate "templates/default.html" defaultContext
          >>= relativizeUrls

papers :: Compiler String
papers = do
  tpl <- loadBody "templates/paper.html"
  ps  <- recentFirst =<< loadAll "papers/*.md"
  applyTemplateList tpl defaultContext ps

-- loadAll :: (.. a) => Pattern -> Compiler [Item a]
-- itemIdentifier :: Item a -> Identifier
-- getMetadataField' :: MonadMetadata m => Identifier -> String -> m String
-- makeItem :: a -> Compiler (Item a)

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
  ps <- loadAll "papers/*.md" :: Compiler [Item String]
  xs <- mapM getAuthorYear ps
  let zss = map unzip $ groupBy ((==) `on` fst) $ sort $ concat xs
  mapM makeItem [ a ++ ": " ++ (concat $ intersperse ", " ys) | (a:_, ys) <- zss ]

compile' =
   compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" defaultContext
      >>= relativizeUrls
