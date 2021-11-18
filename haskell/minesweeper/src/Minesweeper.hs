module Minesweeper (annotate) where

import Data.Char
import Data.Maybe

import Data.Map (Map)
import qualified Data.Map as Map

enum :: [[a]] -> [((Int, Int), a)]
enum board = [((x, y), el) | (y,row) <- zip [0..] board,
                             (x, el) <- zip [0..] row]

mines :: [String] -> [(Int, Int)]
mines board =
  [(x,y) | ((x, y), c) <- enum board , c == '*']

count :: [(Int, Int)] -> Map (Int,Int) Int
count m =
  foldr (\idx cmap -> Map.insertWith (+) idx 1 cmap) Map.empty
  [(x + f, y + g) | f <- [1, -1, 0] , g <- [1, -1, 0]
                  , (x, y) <- m]

countToBoard :: (Int, Int) -> Map (Int, Int) Int -> [(Int, Int)] -> [String]
countToBoard (width, height) countMap mineList =
  let row y = [fromMaybe ' ' (Map.lookup (x,y) fields) | x <- [0..width-1]]
      fields = Map.mapWithKey
               (\idx c -> if elem idx mineList then '*' else intToDigit c)
               countMap
  in
    map row [0..height-1]

annotate :: [String] -> [String]
annotate [] = []
annotate board =
  countToBoard size (count m) m
  where
    size = (length (head board), length board)
    m = mines board
