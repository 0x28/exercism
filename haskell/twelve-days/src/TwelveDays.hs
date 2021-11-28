module TwelveDays (recite) where

import Data.List (intercalate)
import Text.Printf (printf)

nth :: Int -> String
nth 1 = "first"
nth 2 = "second"
nth 3 = "third"
nth 4 = "fourth"
nth 5 = "fifth"
nth 6 = "sixth"
nth 7 = "seventh"
nth 8 = "eighth"
nth 9 = "ninth"
nth 10 = "tenth"
nth 11 = "eleventh"
nth 12 = "twelfth"
nth _ = undefined

gift :: Int -> String
gift 1 = "a Partridge in a Pear Tree."
gift 2 = "two Turtle Doves"
gift 3 = "three French Hens"
gift 4 = "four Calling Birds"
gift 5 = "five Gold Rings"
gift 6 = "six Geese-a-Laying"
gift 7 = "seven Swans-a-Swimming"
gift 8 = "eight Maids-a-Milking"
gift 9 = "nine Ladies Dancing"
gift 10 = "ten Lords-a-Leaping"
gift 11 = "eleven Pipers Piping"
gift 12 = "twelve Drummers Drumming"
gift _ = undefined

day :: Int -> String
day n =
  printf
    "On the %s day of Christmas my true love gave to me: %s"
    (nth n)
    (intercalate ", " [addGift i | i <- [n, n -1 .. 1]])
  where
    addGift i
      | i == 1 && n /= 1 = "and " ++ gift 1
      | otherwise = gift i

recite :: Int -> Int -> [String]
recite start stop = [day n | n <- [start .. stop]]
