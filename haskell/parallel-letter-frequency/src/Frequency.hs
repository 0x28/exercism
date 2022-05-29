module Frequency (frequency) where

import Control.Parallel.Strategies
import Data.Char (isLetter, toLower)
import Data.Map (Map)
import qualified Data.Map as M
import Data.Text (Text)
import qualified Data.Text as T

chunks :: Int -> [a] -> [[a]]
chunks _ [] = []
chunks n xs = prefix : chunks n suffix
  where
    (prefix, suffix) = splitAt n xs

frequency :: Int -> [Text] -> Map Char Int
frequency nWorkers texts = M.unionsWith (+) freqs
  where
    textChunks = chunks (max 1 $ length texts `div` nWorkers) texts
    freqs = parMap rdeepseq (M.unionsWith (+) . map charFreq) textChunks

charFreq :: Text -> Map Char Int
charFreq = T.foldr combine M.empty
  where
    combine c m
      | isLetter c = M.insertWith (+) (toLower c) 1 m
      | otherwise = m
