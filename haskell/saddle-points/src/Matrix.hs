module Matrix (saddlePoints) where

import Data.Array (Array, assocs, bounds, (!))

saddlePoints :: Ord e => Array (Int, Int) e -> [(Int, Int)]
saddlePoints matrix =
  fmap fst $ filter (isSaddlePoint matrix) $ assocs matrix

isSaddlePoint :: Ord e => Array (Int, Int) e -> ((Int, Int), e) -> Bool
isSaddlePoint matrix ((r, c), element) =
  element == maximum row && element == minimum col
  where
    (col, row) = cross matrix c r

cross :: Array (Int, Int) e -> Int -> Int -> ([e], [e])
cross matrix atRow atCol =
  ( [matrix ! (col, atRow) | col <- [colBegin .. colEnd]],
    [matrix ! (atCol, row) | row <- [rowBegin .. rowEnd]]
  )
  where
    ((colBegin, rowBegin), (colEnd, rowEnd)) = bounds matrix
