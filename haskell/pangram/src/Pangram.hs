module Pangram (isPangram) where

import Data.Char

alpha :: String
alpha = ['a' .. 'z']

isPangram :: String -> Bool
isPangram text = all (\c -> elem c (map toLower text)) alpha
