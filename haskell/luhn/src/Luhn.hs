module Luhn (isValid) where

import Data.Char
import Control.Arrow

extractDigits :: String -> [Int]
extractDigits = filter isNumber >>> map digitToInt

luhn' :: [Int] -> [Int]
luhn' (f:s:xs) =
  f : (if double > 9 then double - 9 else double) : luhn' xs
  where double = s * 2
luhn' xs = xs

luhn :: [Int] -> [Int]
luhn = reverse >>> luhn'

isValid :: String -> Bool
isValid n = length digits > 1 && (sum $ luhn digits) `mod` 10 == 0
            where digits = extractDigits n
