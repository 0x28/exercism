module Allergies (Allergen (..), allergies, isAllergicTo) where

import Data.Bits (testBit)

data Allergen
  = Eggs
  | Peanuts
  | Shellfish
  | Strawberries
  | Tomatoes
  | Chocolate
  | Pollen
  | Cats
  deriving (Eq, Show, Enum)

allergies :: Int -> [Allergen]
allergies score = filter (`isAllergicTo` score) [Eggs .. Cats]

isAllergicTo :: Allergen -> Int -> Bool
isAllergicTo allergen score = score `testBit` fromEnum allergen
