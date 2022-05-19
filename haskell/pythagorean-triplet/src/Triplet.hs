module Triplet (tripletsWithSum) where

tripletsWithSum :: Int -> [(Int, Int, Int)]
tripletsWithSum n =
  [ (a, b, c)
    | a <- [1 .. n - 1],
      let b = calcB a n,
      let c = calcC a b,
      a < b && b < c,
      a * a + b * b == c * c,
      a + b + c == n
  ]

calcB :: Int -> Int -> Int
calcB a n = (n * n - 2 * a * n) `div` (2 * n - 2 * a)

calcC :: Int -> Int -> Int
calcC a b = round $ sqrt ((fromIntegral $ a * a + b * b) :: Float)
