module Diamond (diamond) where

import Data.Char (isUpper)

diamond :: Char -> Maybe [String]
diamond c
  | isUpper c = Just $ triangle ++ tail (reverse triangle)
  | otherwise = Nothing
  where
    triangle = zipWith row [0 ..] range
    range = ['A' .. c]
    middle = length range - 1
    row idx letter =
      let fun i = if i == middle - idx || i == middle + idx then letter else ' '
       in map fun [0 .. middle * 2]
