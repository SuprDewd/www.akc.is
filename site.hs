{-# LANGUAGE OverloadedStrings #-}
import Control.Applicative ((<$>))
import Data.Monoid ((<>), mconcat)
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

papers :: Compiler String
papers = do
  tpl <- loadBody "templates/paper.html"
  ps  <- loadAll "papers/*.md" >>= recentFirst
  applyTemplateList tpl defaultContext ps

compile' =
   compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" defaultContext
      >>= relativizeUrls
