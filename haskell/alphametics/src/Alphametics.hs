module Alphametics (solve) where

import qualified Data.IntSet as IntSet
import Data.List (transpose)
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe (listToMaybe)
import Data.Set (Set)
import qualified Data.Set as Set

data Puzzle = Puzzle
  { columns :: [([Char], Char)],
    variables :: [Char],
    initials :: Set Char
  }
  deriving (Show)

splitLast :: [a] -> ([a], a)
splitLast [] = undefined
splitLast [x] = ([], x)
splitLast (x : xs) = (x : xs', x')
  where
    (xs', x') = splitLast xs

dedup :: Eq a => [a] -> [a]
dedup [] = []
dedup (x : xs) = x : filter (/= x) (dedup xs)

parse :: String -> Puzzle
parse input = Puzzle {columns = cols, variables = vars, initials = inits}
  where
    -- get vars right to left
    vars = dedup $ foldr (\(as, a) b -> a : as ++ b) [] cols
    cols = fmap splitLast $ transpose $ map reverse addends
    inits = Set.fromList $ map head addends
    addends = (parse' . words) input
    parse' (word : "+" : rest) = word : parse' rest
    parse' (word : "==" : rest) = word : parse' rest
    parse' [word] = [word]
    parse' _ = error ("Syntax error in " ++ input)

possibilities :: Puzzle -> [Map Char Int]
possibilities puzzle =
  map snd $ possibilities' $ variables puzzle
  where
    possibilities' [] = [(IntSet.empty, Map.empty)]
    possibilities' (v : vars) =
      [ (IntSet.insert num s, newMap)
        | (s, m) <- mappings,
          num <- [0 .. 9],
          IntSet.notMember num s,
          let newMap = Map.insert v num m,
          check puzzle newMap
      ]
      where
        mappings = possibilities' vars

check :: Puzzle -> Map Char Int -> Bool
check puzzle mapping = firstValid && check' (columns puzzle) 0
  where
    firstValid = all (\i -> Map.lookup i mapping /= Just 0) (initials puzzle)
    check' [] _ = True
    check' ((digits, digitSum) : cols) carry
      | proceed = valid && check' cols (colSum `div` 10)
      | otherwise = True
      where
        proceed = Map.member digitSum mapping && all (`Map.member` mapping) digits
        colSum = sum (map (mapping Map.!) digits) + carry
        valid = colSum `mod` 10 == (Map.!) mapping digitSum `mod` 10

solve :: String -> Maybe [(Char, Int)]
solve input = listToMaybe $ map Map.assocs solutions
  where
    puzzle = parse input
    solutions = possibilities puzzle
