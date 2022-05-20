module Yacht (yacht, Category (..)) where

import Data.List (partition, sort)

data Category
  = Ones
  | Twos
  | Threes
  | Fours
  | Fives
  | Sixes
  | FullHouse
  | FourOfAKind
  | LittleStraight
  | BigStraight
  | Choice
  | Yacht

allEqual :: Eq a => [a] -> Bool
allEqual [] = True
allEqual (x : xs) = all (== x) xs

yacht :: Category -> [Int] -> Int
yacht Ones dice = sum $ filter (== 1) dice
yacht Twos dice = sum $ filter (== 2) dice
yacht Threes dice = sum $ filter (== 3) dice
yacht Fours dice = sum $ filter (== 4) dice
yacht Fives dice = sum $ filter (== 5) dice
yacht Sixes dice = sum $ filter (== 6) dice
yacht FullHouse dice@(d : _)
  | allEqual p1 && allEqual p2 && (length p1 == 3 || length p2 == 3) = sum dice
  where
    (p1, p2) = partition (== d) dice
yacht FourOfAKind dice@(d : _)
  | allEqual p1 && length p1 >= 4 = sum $ take 4 p1
  | allEqual p2 && length p2 >= 4 = sum $ take 4 p2
  where
    (p1, p2) = partition (== d) dice
yacht LittleStraight dice
  | sort dice == [1, 2, 3, 4, 5] = 30
yacht BigStraight dice
  | sort dice == [2, 3, 4, 5, 6] = 30
yacht Choice dice = sum dice
yacht Yacht dice
  | allEqual dice = 50
yacht _ _ = 0
