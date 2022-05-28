module BinarySearch (find) where

import Data.Array

find :: Ord a => Array Int a -> a -> Maybe Int
find arr x = uncurry find' (bounds arr)
  where
    find' begin end
      | begin > end = Nothing
      | middle < x = find' (middleIdx + 1) end
      | middle > x = find' begin (middleIdx - 1)
      | otherwise = Just middleIdx
      where
        middleIdx = begin + (end - begin) `div` 2
        middle = arr ! middleIdx
