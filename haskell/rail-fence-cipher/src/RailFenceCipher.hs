module RailFenceCipher (encode, decode) where

import Data.Map (Map)
import qualified Data.Map as M
import Data.Maybe (catMaybes)

makeFence :: Int -> [a] -> Map (Int, Int) a
makeFence n input = M.fromList $ separate' 0 0 input succ
  where
    separate' _ _ [] _ = []
    separate' x y (c : cs) next
      | y == n - 1 = ((x, y), c) : separate' (succ x) (y - 1) cs pred
      | y == 0 = ((x, y), c) : separate' (succ x) (y + 1) cs succ
      | otherwise = ((x, y), c) : separate' (succ x) (next y) cs next

encode :: Int -> String -> String
encode n input =
  catMaybes
    [ M.lookup (x, y) fence
      | y <- [0 .. n],
        x <- [0 .. length input]
    ]
  where
    fence = makeFence n input

decode :: Int -> String -> String
decode n input =
  catMaybes [M.lookup x decoded | x <- [0 .. len]]
  where
    len = length input
    decoded = fill (0, 0) input M.empty
    fence = makeFence n $ replicate len '?'
    fill _ [] m = m
    fill pos@(x, y) (c : cs) m = case M.lookup pos fence of
      Just _ -> fill nextPos cs (M.insert x c m)
      Nothing -> fill nextPos (c : cs) m
      where
        nextPos = if x == len - 1 then (0, y + 1) else (x + 1, y)
