module PrimeFactors (primeFactors) where

primeFactors :: Integer -> [Integer]
primeFactors = factors [2..]
  where
    factors [] _ = []
    factors (p:ps) num
      | p > num = []
      | num `mod` p == 0 = p : factors (p:ps) (num `div` p)
      | otherwise = factors ps num
