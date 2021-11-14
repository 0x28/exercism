module Anagram (anagramsFor) where

import Data.List
import Data.Char

normalize :: String -> String
normalize = sort . map toLower

downcase :: String -> String
downcase = map toLower

anagramsFor :: String -> [String] -> [String]
anagramsFor xs xss =
  let normal = normalize xs
  in
    filter (\s -> normalize s == normal && downcase s /= downcase xs) xss
