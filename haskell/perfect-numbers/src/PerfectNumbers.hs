module PerfectNumbers (classify, Classification(..)) where

data Classification = Deficient | Perfect | Abundant deriving (Eq, Show)

factors :: Int -> [Int]
factors n = [f | f <- [1..(n `div` 2)], n `mod` f == 0]

classify :: Int -> Maybe Classification
classify n
  | n <= 0 = Nothing
  | otherwise = case compare (sum $ factors n) n of
                  EQ -> Just Perfect
                  GT -> Just Abundant
                  LT -> Just Deficient
