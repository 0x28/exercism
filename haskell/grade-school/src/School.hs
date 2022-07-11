module School (School, add, empty, grade, sorted) where

import Data.List (sort, sortOn)
import Data.Maybe (fromMaybe)
import GHC.Exts (groupWith)

type School = [(Int, String)]

add :: Int -> String -> School -> School
add gradeNum student school = (gradeNum, student) : school

empty :: School
empty = []

grade :: Int -> School -> [String]
grade gradeNum = fromMaybe [] . lookup gradeNum . sorted

sorted :: School -> [(Int, [String])]
sorted = map (\s -> (fst $ head s, sort $ map snd s)) . groupWith fst . sortOn fst
