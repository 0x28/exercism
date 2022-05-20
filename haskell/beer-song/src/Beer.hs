module Beer (song) where

import Text.Printf (printf)

beer :: Int -> [Char]
beer 0 =
  "No more bottles of beer on the wall, no more bottles of beer.\n\
  \Go to the store and buy some more, 99 bottles of beer on the wall."
beer n =
  printf
    "%s of beer on the wall, %s of beer.\n\
    \Take %s down and pass it around, %s of beer on the wall.\n"
    (bottles n)
    (bottles n)
    (if n == 1 then "it" else "one")
    (bottles (n - 1))

bottles :: Int -> String
bottles 0 = "no more bottles"
bottles 1 = "1 bottle"
bottles n = printf "%d bottles" n

song :: String
song = unlines $ reverse $ map beer [0 .. 99]
