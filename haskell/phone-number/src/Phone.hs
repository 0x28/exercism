module Phone (number) where

import Data.Char

isNANP :: String -> Bool
isNANP str = length str == 10 && area > '1' && exchange > '1'
  where area = str !! 0
        exchange = str !! 3

number :: String -> Maybe String
number xs = case filter isDigit xs of
              '1':rest | isNANP rest -> Just rest
              str      | isNANP str  -> Just str
              _                      -> Nothing
