module House (rhyme) where

import Data.List (intercalate)

objects :: [String]
objects =
  [ "the horse and the hound and the horn",
    "the farmer sowing his corn",
    "the rooster that crowed in the morn",
    "the priest all shaven and shorn",
    "the man all tattered and torn",
    "the maiden all forlorn",
    "the cow with the crumpled horn",
    "the dog",
    "the cat",
    "the rat",
    "the malt",
    "the house that Jack built."
  ]

actions :: [String]
actions =
  [ "that belonged to ",
    "that kept ",
    "that woke ",
    "that married ",
    "that kissed ",
    "that milked ",
    "that tossed ",
    "that worried ",
    "that killed ",
    "that ate ",
    "that lay in "
  ]

rhyme :: String
rhyme = intercalate "\n" $ reverse $ createRhyme actions objects

createRhyme :: [String] -> [String] -> [String]
createRhyme acts@(_ : as) objs@(_ : os) =
  unlines (zipWith (++) ("This is " : acts) objs) : createRhyme as os
createRhyme _ [o] = ["This is " ++ o ++ "\n"]
createRhyme _ _ = []
