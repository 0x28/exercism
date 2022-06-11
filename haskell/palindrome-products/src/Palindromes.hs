module Palindromes (largestPalindrome, smallestPalindrome) where

import Data.Maybe (listToMaybe)

-- checking every number from the beginning is faster than looking at every
-- factor pair for small palindromes
smallestPalindrome :: Int -> Int -> Maybe (Int, [(Int, Int)])
smallestPalindrome begin end = listToMaybe pal
  where
    pal = take 1 $ filter (\(p, fs) -> isPalindromeNum p && fs /= []) $ map factor range
    range = [begin * begin .. end * end]
    factor p = (p, factorize begin end p)

-- for large palindromes only looking at the factors is faster
largestPalindrome :: Int -> Int -> Maybe (Int, [(Int, Int)])
largestPalindrome minFactor maxFactor = select palis
  where
    select [] = Nothing
    select (p : ps) = Just $ optimize p ps
    palis = map multiply $ filter isPalindrome $ factors [minFactor .. maxFactor]
    isPalindrome (a, b) = isPalindromeNum (a * b)
    multiply (a, b) = (a * b, [(a, b)])
    optimize old [] = old
    optimize old@(acc, fs) (new@(p, fs') : ps) =
      case compare acc p of
        GT -> optimize old ps
        LT -> optimize new ps
        EQ -> optimize (acc, fs ++ fs') ps

factors :: Ord a => [a] -> [(a, a)]
factors xs = [(a, b) | a <- xs, b <- xs, a <= b]

factorize :: Int -> Int -> Int -> [(Int, Int)]
factorize begin end n = if begin == 1 then (1, n) : fs else fs
  where
    fs =
      [ (a, b)
        | a <- [begin .. end],
          b <- [begin .. end],
          a * b == n && a <= b
      ]

isPalindromeNum :: Int -> Bool
isPalindromeNum n = show n == reverse (show n)
