module Scrabble (scoreLetter, scoreWord) where

import Data.Char (toUpper)

scoreLetter :: Char -> Integer
scoreLetter letter
  | upper `elem` "AEIOULNRST" = 1
  | upper `elem` "DG" = 2
  | upper `elem` "BCMP" = 3
  | upper `elem` "FHVWY" = 4
  | upper == 'K' = 5
  | upper `elem` "JX" = 8
  | upper `elem` "QZ" = 10
  | otherwise = 0
  where
    upper = toUpper letter

scoreWord :: String -> Integer
scoreWord word = sum $ map scoreLetter word
