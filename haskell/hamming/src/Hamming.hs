module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance xs ys
  | length xs == length ys = Just $ sum $ [1 | (l, r) <- zip xs ys, l /= r]
  | otherwise = Nothing
