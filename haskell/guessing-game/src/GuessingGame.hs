module GuessingGame (reply) where

correct :: Int
correct = 42

reply :: Int -> String
reply guess
  | guess == correct = "Correct"
  | abs (guess - correct) == 1 = "So close"
  | guess < correct = "Too low"
  | otherwise = "Too high"
