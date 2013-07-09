{-# LANGUAGE OverloadedStrings #-}
import Data.Monoid (mappend, mconcat)
import Hakyll
import Papers

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

  -- create ["papers.html"] $ do
  --    route idRoute
  --    compile $ do
  --      paper <- papers
  --      makeItem $ itemBody 

paperContext :: Paper -> Context String
paperContext p =
    mconcat [ constField "Authors"  (authors p)
            , constField "Title"    (title   p)
            , constField "Journal"  (journal p)
            , constField "Volume"   (volume  p)
            , constField "Pages"    (pages   p)
            , constField "Year"     (year    p)
            , constField "Note"     (note    p)
            , constField "URL"      (url     p)
            , constField "UnixTime" (show (unixtime p))
            , defaultContext
            ]

-- paperCompiler = do
--   let paper = head papers
--   tpl   <- loadBody "templates/paper.html"
--   applyTemplate tpl (paperContext paper) (makeItem "")
