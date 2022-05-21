module RotationalCipher (rotate) where

import Data.Char (isUpper, isLower, ord, chr)

rotate :: Int -> String -> String
rotate n = map (rotate' n)

rotate' :: Int -> Char -> Char
rotate' n c
  | isUpper c = chr $ upperStart + (ord c + n - upperStart) `mod` 26
  | isLower c = chr $ lowerStart + (ord c + n - lowerStart) `mod` 26
  | otherwise = c
  where
    upperStart = ord 'A'
    lowerStart = ord 'a'
