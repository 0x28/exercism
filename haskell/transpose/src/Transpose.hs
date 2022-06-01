module Transpose (transpose) where

transpose :: [String] -> [String]
transpose [] = []
transpose [l] = map (: []) l
transpose (l : ls) = addColumn l $ transpose ls
  where
    addColumn [] [] = []
    addColumn (char : chars) [] = [char] : addColumn chars []
    addColumn [] (col : cols) = (' ' : col) : addColumn [] cols
    addColumn (char : chars) (col : cols) = (char : col) : addColumn chars cols
