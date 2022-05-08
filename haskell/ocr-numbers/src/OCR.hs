module OCR (convert) where

import Data.List (intercalate, transpose)

convert :: String -> String
convert xs = intercalate "," rows
  where
    rows = map (map recognize . splitDigits) $ chunk 4 $ lines xs

chunk :: Int -> [a]-> [[a]]
chunk _ [] = []
chunk n xs = take n xs : chunk n (drop n xs)

splitDigits :: [String] -> [[String]]
splitDigits xs = transpose $ map (chunk 3) xs

recognize :: [String] -> Char
recognize
  [ " _ ",
    "| |",
    "|_|",
    "   "
    ] = '0'
recognize
  [ "   ",
    "  |",
    "  |",
    "   "
    ] = '1'
recognize
  [ " _ ",
    " _|",
    "|_ ",
    "   "
    ] = '2'
recognize
  [ " _ ",
    " _|",
    " _|",
    "   "
    ] = '3'
recognize
  [ "   ",
    "|_|",
    "  |",
    "   "
    ] = '4'
recognize
  [ " _ ",
    "|_ ",
    " _|",
    "   "
    ] = '5'
recognize
  [ " _ ",
    "|_ ",
    "|_|",
    "   "
    ] = '6'
recognize
  [ " _ ",
    "  |",
    "  |",
    "   "
    ] = '7'
recognize
  [ " _ ",
    "|_|",
    "|_|",
    "   "
    ] = '8'
recognize
  [ " _ ",
    "|_|",
    " _|",
    "   "
    ] = '9'
recognize _ = '?'
