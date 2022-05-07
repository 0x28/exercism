module FoodChain (song) where

import Data.Char (toLower)
import Data.List (inits)
import Text.Printf (printf)

data Animal = Fly | Spider | Bird | Cat | Dog | Goat | Cow | Horse
  deriving (Show, Enum)

toString :: Animal -> String
toString = map toLower . show

why :: Animal -> String
why Fly = "I don't know why she swallowed the fly. Perhaps she'll die."
why hunter =
  printf "She swallowed the %s to catch the %s." (toString hunter) (out prey)
  where
    out Spider = "spider that wriggled and jiggled and tickled inside her"
    out _ = toString prey
    prey = pred hunter

comment :: Animal -> String
comment Spider = "It wriggled and jiggled and tickled inside her."
comment Bird = "How absurd to swallow a bird!"
comment Cat = "Imagine that, to swallow a cat!"
comment Dog = "What a hog, to swallow a dog!"
comment Goat = "Just opened her throat and swallowed a goat!"
comment Cow = "I don't know how she swallowed a cow!"
comment Horse = "She's dead, of course!"
comment _ = undefined

swallowed :: Animal -> String
swallowed animal = printf "I know an old lady who swallowed a %s." $ toString animal

strophe :: [Animal] -> String
strophe [] = undefined
strophe [first] = unlines [swallowed first, why Fly]
strophe (Horse : _) = swallowed Horse ++ "\n" ++ comment Horse
strophe animals@(first : _) = unlines (swallowed first : comment first : whys)
  where
    whys = map why animals

song :: String
song = unlines $ map strophe $ tail $ map reverse $ inits [Fly .. Horse]
