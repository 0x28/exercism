module Sublist (sublist) where

import Data.List (isPrefixOf, tails)

sublist :: Eq a => [a] -> [a] -> Maybe Ordering
sublist xs ys
  | xs == ys = Just EQ
  | any (isPrefixOf xs) $ tails ys = Just LT
  | any (isPrefixOf ys) $ tails xs = Just GT
  | otherwise = Nothing
