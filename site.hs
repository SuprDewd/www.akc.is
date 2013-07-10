{-# LANGUAGE OverloadedStrings #-}
import Data.Monoid ((<>), mconcat)
import Hakyll

main :: IO ()
main = hakyll $ do
  match ("images/*.png" .||. "images/*.ico" .||. "fonts/*") $ do
    route   idRoute
    compile copyFileCompiler

  match "css/*" $ do
    route   idRoute
    compile compressCssCompiler

  match "templates/*" $ compile templateCompiler

  match "index.md" $ do
     route   $ setExtension "html"
     compile $ pandocCompiler
        >>= loadAndApplyTemplate "templates/default.html" defaultContext
        >>= relativizeUrls

  match "papers/*.md" $ compile $ pandocCompiler

  create ["papers.html"] $ do
     route idRoute
     compile $ do
       p <- papers
       let ctx = constField "title" "Papers and preprints" <> constField "papers" p <> defaultContext
       makeItem ""
          >>= loadAndApplyTemplate "templates/papers.html" ctx
          >>= loadAndApplyTemplate "templates/default.html" defaultContext

  -- create ["papers.html"] $ do
  --    route idRoute
  --    compile $ do
  --      p <- papers
  --      makeItem ""
  --         >>= loadAndApplyTemplate "templates/default.html" (titleField "Buhu" <> bodyField "HELLO!")
  --         >>= relativizeUrls

papers :: Compiler String
papers = do
  tpl <- loadBody "templates/paper.html"
  ps  <- loadAll "papers/*.md"
  applyTemplateList tpl defaultContext ps
