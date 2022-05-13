module IsbnVerifier (isbn) where

import Data.Char (digitToInt, isDigit)
import Data.Maybe (mapMaybe)

isbn :: String -> Bool
isbn xs = verify $ mapMaybe parse xs
  where
    parse c
      | c == 'X' = Just 10
      | isDigit c = Just $ digitToInt c
      | otherwise = Nothing

verify :: [Int] -> Bool
verify xs@[x1, x2, x3, x4, x5, x6, x7, x8, x9, x10] =
  (x1 * 10 + x2 * 9 + x3 * 8 + x4 * 7 + x5 * 6 + x6 * 5 + x7 * 4 + x8 * 3 + x9 * 2 + x10) `mod` 11 == 0
    && all (< 10) (take 9 xs)
verify _ = False
