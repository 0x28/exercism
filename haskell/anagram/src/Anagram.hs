module Anagram (anagramsFor) where

import Data.Char

import Data.Map (Map)
import qualified Data.Map as Map

charCount :: String -> Map Char Int
charCount = foldr (\c s -> Map.insertWith (+) (toLower c) 1 s) Map.empty

downcase :: String -> String
downcase = map toLower

anagramsFor :: String -> [String] -> [String]
anagramsFor xs xss =
  let count = charCount xs
  in
    filter (\s -> charCount s == count && downcase s /= downcase xs) xss
