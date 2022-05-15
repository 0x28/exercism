module Bowling (score, BowlingError (..)) where

data BowlingError
  = IncompleteGame
  | InvalidRoll {rollIndex :: Int, rollValue :: Int}
  deriving (Eq, Show)

score :: [Int] -> Either BowlingError Int
score = calcScore 0 1

calcScore :: Int -> Int -> [Int] -> Either BowlingError Int
calcScore _ frame []
  | frame == 10 = Right 0
  | otherwise = Left IncompleteGame
calcScore index _ (r : _)
  | r < 0 || r > 10 = Left InvalidRoll {rollIndex = index, rollValue = r}
calcScore index frame rest
  | frame == 10 = lastFrame index frame rest
calcScore index frame (10 : rest) = strike index frame rest
calcScore index frame (f : s : rest)
  | f + s == 10 = spare index frame rest
  | f + s > 10 = Left InvalidRoll {rollIndex = index + 1, rollValue = s}
  | otherwise = (\v -> v + f + s) <$> calcScore (index + 2) (frame + 1) rest
calcScore _ _ [_] = Left IncompleteGame

lastFrame :: Int -> Int -> [Int] -> Either BowlingError Int
lastFrame index _ [10, a, b]
  | a + b > 10 && a /= 10 = Left InvalidRoll {rollIndex = index + 2, rollValue = b}
  | a <= 10 && b <= 10 = Right $ 10 + a + b
  | otherwise = Left InvalidRoll {rollIndex = index + 2, rollValue = b}
lastFrame index _ [10, r]
  | r > 10 = Left InvalidRoll {rollIndex = index + 1, rollValue = r}
  | otherwise = Left IncompleteGame
lastFrame _ _ [10] = Left IncompleteGame
lastFrame index _ [a, b, c]
  | a + b == 10 = Right $ a + b + c
  | otherwise = Left InvalidRoll {rollIndex = index + 2, rollValue = c}
lastFrame _ _ [a, b]
  | a + b == 10 = Left IncompleteGame
  | otherwise = Right $ a + b
lastFrame index _ (_ : _ : _ : c : _) =
  Left InvalidRoll {rollIndex = index + 3, rollValue = c}
lastFrame _ _ _ = Left IncompleteGame

spare :: Int -> Int -> [Int] -> Either BowlingError Int
spare index frame (r : rs) = (\v -> v + 10 + r) <$> calcScore (index + 2) (frame + 1) (r : rs)
spare _ _ [] = Left IncompleteGame

strike :: Int -> Int -> [Int] -> Either BowlingError Int
strike index frame rolls@(r1 : r2 : _) =
  (\v -> v + 10 + r1 + r2) <$> calcScore (index + 1) (frame + 1) rolls
strike _ _ _ = Left IncompleteGame
