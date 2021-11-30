module Change (findFewestCoins) where

import Data.List (find)
import Data.Maybe (isJust)

type Change = [(Integer, [Integer])]

addToChange :: Integer -> [Integer] -> Change -> Change
addToChange target coins current =
  [ (s, coin : oldCoins)
    | coin <- coins,
      (oldSum, oldCoins) <- current,
      let s = coin + oldSum,
      s <= target,
      decreasing coin oldCoins
  ]
  where
    decreasing n (x : _) = n <= x
    decreasing _ [] = True

findChange :: Integer -> [Integer] -> Change -> Maybe [Integer]
findChange target coins prev
  | isJust solution = fmap snd solution
  | current == prev = Nothing
  | otherwise = findChange target coins current
  where
    current = addToChange target coins prev
    solution = find (\(s, _) -> s == target) current

findFewestCoins :: Integer -> [Integer] -> Maybe [Integer]
findFewestCoins 0 _ = Just []
findFewestCoins target coins = findChange target coins [(0, [])]
