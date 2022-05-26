module Spiral (spiral) where

import Data.List (sortBy)

data Direction = North | East | South | West

chunks :: Int -> [a] -> [[a]]
chunks _ [] = []
chunks n xs = take n xs : chunks n (drop n xs)

spiral :: Int -> [[Int]]
spiral 0 = []
spiral size = chunks size $ map fst $ sortBy cmp $ zip [1 ..] coords
  where
    cmp (_, coord1) (_, coord2) = compare coord1 coord2
    coords = spiralPos 0 (size - 1) East (0, 0)

spiralPos :: Int -> Int -> Direction -> (Int, Int) -> [(Int, Int)]
spiralPos minCoord maxCoord _ pos
  | minCoord > maxCoord = [pos]
spiralPos minCoord maxCoord North (y, x)
  | y > minCoord + 1 = (y, x) : spiralPos minCoord maxCoord North (y - 1, x)
  | otherwise = spiralPos (minCoord + 1) (maxCoord - 1) East (y, x)
spiralPos minCoord maxCoord East (y, x)
  | x < maxCoord = (y, x) : spiralPos minCoord maxCoord East (y, x + 1)
  | otherwise = spiralPos minCoord maxCoord South (y, x)
spiralPos minCoord maxCoord South (y, x)
  | y < maxCoord = (y, x) : spiralPos minCoord maxCoord South (y + 1, x)
  | otherwise = spiralPos minCoord maxCoord West (y, x)
spiralPos minCoord maxCoord West (y, x)
  | x > minCoord = (y, x) : spiralPos minCoord maxCoord West (y, x - 1)
  | otherwise = spiralPos minCoord maxCoord North (y, x)
