module ZebraPuzzle (Resident (..), Solution (..), solve) where

import Data.Foldable (find)
import Data.List (permutations, zipWith6)
import Data.Maybe (fromJust)

data Resident = Englishman | Spaniard | Ukrainian | Norwegian | Japanese
  deriving (Eq, Show, Enum)

data Solution = Solution {waterDrinker :: Resident, zebraOwner :: Resident}
  deriving (Eq, Show)

data Beverage = Coffee | Water | Milk | OrangeJuice | Tea
  deriving (Eq, Show, Enum)

data Color = Red | Green | Blue | Yellow | Ivory
  deriving (Eq, Show, Enum)

data Cigarette = LuckyStrike | Parliament | OldGold | Kool | Chesterfield
  deriving (Eq, Show, Enum)

data Number = One | Two | Three | Four | Five
  deriving (Eq, Show, Enum)

data Pet = Zebra | Dog | Fox | Snail | Horse
  deriving (Eq, Show, Enum)

data House = House
  { number :: Number,
    resident :: Resident,
    beverage :: Beverage,
    color :: Color,
    cigarette :: Cigarette,
    animal :: Pet
  }
  deriving (Eq, Show)

houses :: [House]
houses =
  head
    [ zipWith6 House num res bev col cig pet
      | col <- permutations [Red .. Ivory],
        res <- permutations [Englishman .. Japanese],
        ensureFact (Englishman, Red) res col,
        num <- permutations [One .. Five],
        ensureFact (Two, Blue) num col,
        ensureFact (One, Norwegian) num res,
        bev <- permutations [Coffee .. Tea],
        ensureFact (Ukrainian, Tea) res bev,
        ensureFact (Three, Milk) num bev,
        ensureFact (Green, Coffee) col bev,
        pet <- permutations [Zebra .. Horse],
        ensureFact (Spaniard, Dog) res pet,
        cig <- permutations [LuckyStrike .. Chesterfield],
        ensureFact (OldGold, Snail) cig pet,
        ensureFact (Kool, Yellow) cig col,
        ensureFact (OrangeJuice, LuckyStrike) bev cig,
        ensureFact (Japanese, Parliament) res cig,
        filterHouses $ zipWith6 House num res bev col cig pet
    ]

filterHouses :: [House] -> Bool
filterHouses hs
  | not $ number greenHouse `isRightTo` number ivoryHouse = False
  | not $ number chesterHouse `isNextTo` number foxHouse = False
  | not $ number horseHouse `isNextTo` number koolHouse = False
  | otherwise = True
  where
    isRightTo a b = fromEnum a - fromEnum b == 1
    isNextTo a b = abs (fromEnum a - fromEnum b) == 1
    greenHouse = fromJust $ find ((== Green) . color) hs
    ivoryHouse = fromJust $ find ((== Ivory) . color) hs
    foxHouse = fromJust $ find ((== Fox) . animal) hs
    chesterHouse = fromJust $ find ((== Chesterfield) . cigarette) hs
    horseHouse = fromJust $ find ((== Horse) . animal) hs
    koolHouse = fromJust $ find ((== Kool) . cigarette) hs

ensureFact :: (Eq a, Eq b) => (a, b) -> [a] -> [b] -> Bool
ensureFact (attr1, attr2) as bs = and $ zipWith applyFact' as bs
  where
    applyFact' x y
      | x == attr1 = y == attr2
      | y == attr2 = x == attr1
      | otherwise = True

solve :: Solution
solve = Solution (findWater hs) (findZebra hs)
  where
    hs = houses
    findZebra = resident . fromJust . find ((==) Zebra . animal)
    findWater = resident . fromJust . find ((==) Water . beverage)
