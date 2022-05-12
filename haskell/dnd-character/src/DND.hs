{-# LANGUAGE RecordWildCards #-}

module DND
  ( Character (..),
    ability,
    modifier,
    character,
  )
where

import Data.List (sort)
import Test.QuickCheck (Gen, choose, vectorOf)

data Character = Character
  { strength :: Int,
    dexterity :: Int,
    constitution :: Int,
    intelligence :: Int,
    wisdom :: Int,
    charisma :: Int,
    hitpoints :: Int
  }
  deriving (Show, Eq)

modifier :: Int -> Int
modifier cons = (cons - 10) `div` 2

ability :: Gen Int
ability =
  do
    rolls <- vectorOf 4 $ choose (1, 6)
    return (sum $ drop 1 $ sort rolls)

character :: Gen Character
character =
  do
    strength <- ability
    dexterity <- ability
    constitution <- ability
    intelligence <- ability
    wisdom <- ability
    charisma <- ability
    let hitpoints = 10 + modifier constitution
    return Character {..}
