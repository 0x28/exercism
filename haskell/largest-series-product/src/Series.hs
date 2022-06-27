module Series (Error (..), largestProduct) where

import Data.Char (digitToInt, isDigit)

data Error = InvalidSpan | InvalidDigit Char deriving (Show, Eq)

windows :: Int -> [a] -> [[a]]
windows _ [] = []
windows n (x : xs)
  | length chunk < n = []
  | otherwise = chunk : windows n xs
  where
    chunk = take n (x : xs)

calcProduct :: String -> Either Error Integer
calcProduct [] = Right 1
calcProduct (d : ds)
  | isDigit d = (toInteger (digitToInt d) *) <$> calcProduct ds
  | otherwise = Left $ InvalidDigit d

largestProduct :: Int -> String -> Either Error Integer
largestProduct size digits
  | size < 0 || length digits < size = Left InvalidSpan
  | null digits || size == 0 = Right 1
  | otherwise = maximum <$> mapM calcProduct (windows size digits)
