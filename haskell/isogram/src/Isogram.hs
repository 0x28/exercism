module Isogram (isIsogram) where

import Data.Char (isAlpha, toLower)
import Data.List (sort)

isIsogram :: String -> Bool
isIsogram = isIsogram' . sort . map toLower . filter isAlpha
  where
    isIsogram' (f : s : cs) = f < s && isIsogram' (s : cs)
    isIsogram' _ = True
