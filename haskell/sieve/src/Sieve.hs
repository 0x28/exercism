module Sieve (primesUpTo) where

-- You should not use any of the division operations when implementing
-- the sieve of Eratosthenes.
import Prelude hiding (div, divMod, mod, quot, quotRem, rem, (/))

sieve :: Integer -> [Integer] -> [Integer]
sieve _ [] = []
sieve n xs = sieve' (n - 1) xs
  where
    sieve' _ [] = []
    sieve' 0 (_ : ys) = 0 : sieve' (n - 1) ys
    sieve' i (y : ys) = y : sieve' (i - 1) ys

primes :: [Integer]
primes = filter (> 0) $ primes' [2 ..]
  where
    primes' [] = []
    primes' (x : xs) = x : primes' (sieve x xs)

primesUpTo :: Integer -> [Integer]
primesUpTo n
  | n < 2 = []
  | otherwise = takeWhile (<= n) primes
