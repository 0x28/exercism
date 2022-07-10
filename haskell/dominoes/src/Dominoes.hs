module Dominoes (chain) where

import Data.List (delete)
import Data.Maybe (listToMaybe)

chain :: [(Int, Int)] -> Maybe [(Int, Int)]
chain [] = Just []
chain dominoes = listToMaybe $ possibilities dominoes

isValid :: Int -> (Int, Int) -> Bool
isValid v (a, b) = v == a || v == b

rotate :: Int -> (Int, Int) -> (Int, Int)
rotate v (a, b)
  | v == a = (b, a)
  | otherwise = (a, b)

possibilities :: [(Int, Int)] -> [[(Int, Int)]]
possibilities [] = []
possibilities (x : xs) = possibilities' [x] xs
  where
    possibilities' [] _ = []
    possibilities' placed@((f, _) : _) [] = [placed | f == snd x]
    possibilities' placed@((a, _) : _) rest =
      concatMap
        (uncurry possibilities')
        [(rotate a r : placed, delete r rest) | r <- rest, isValid a r]
