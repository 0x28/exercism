module Proverb (recite) where

import Data.List (intercalate)
import Text.Printf (printf)

windows2 :: [x] -> [(x, x)]
windows2 [] = []
windows2 [_] = []
windows2 (a : b : rest) = (a, b) : windows2 (b : rest)

recite :: [String] -> String
recite [] = ""
recite xs = intercalate "\n" phrases
  where
    phrase = printf "For want of a %s the %s was lost."
    end = printf "And all for the want of a %s." $ head xs
    phrases = foldr (\(a, b) acc -> phrase a b : acc) [end] $ windows2 xs
