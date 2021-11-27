module WordCount (wordCount) where

import Control.Arrow
import Data.Char (isAlphaNum)
import qualified Data.Text as T
import Data.Text (Text)
import qualified Data.Map as M
import Data.Map (Map)

isPunctuation :: Char -> Bool
isPunctuation c = not (c == '\'' || isAlphaNum c)

splitWords :: Text -> [Text]
splitWords = T.split isPunctuation
  >>> filter (not . T.null)
  >>> map (T.dropAround (not . isAlphaNum) >>> T.toLower)

counts :: [Text] -> Map Text Int
counts = foldr (\w m -> M.insertWith (+) w 1 m) M.empty

wordCount :: Text -> Map Text Int
wordCount = counts . splitWords
