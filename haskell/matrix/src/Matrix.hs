module Matrix
  ( Matrix,
    cols,
    column,
    flatten,
    fromList,
    fromString,
    reshape,
    row,
    rows,
    shape,
    transpose,
  )
where

import Control.Monad (join)
import Data.Maybe (fromMaybe)
import Data.Vector (Vector, (!), (!?))
import qualified Data.Vector as V

data Matrix a = Matrix {cols :: Int, rows :: Int, content :: Vector (Vector a)}
  deriving (Eq, Show)

column :: Int -> Matrix a -> Vector a
column x matrix = V.map (! (x - 1)) (content matrix)

flatten :: Matrix a -> Vector a
flatten matrix = join (content matrix)

fromList :: [[a]] -> Matrix a
fromList xss =
  Matrix
    { cols = length $ fromMaybe V.empty (cells !? 0),
      rows = length cells,
      content = cells
    }
  where
    cells = V.map V.fromList $ V.fromList xss

fromString :: Read a => String -> Matrix a
fromString xs =
  Matrix
    { cols = length $ fromMaybe V.empty (cells !? 0),
      rows = length cells,
      content = cells
    }
  where
    inLines = V.fromList $ lines xs
    cells = V.map (V.fromList . map read . words) inLines

reshape :: (Int, Int) -> Matrix a -> Matrix a
reshape (newRows, newCols) matrix =
  Matrix
    { cols = newCols,
      rows = newRows,
      content = V.generate newRows (V.generate newCols . select)
    }
  where
    oldCols = cols matrix
    absIdx r c = r * newCols + c
    calcRow i = i `div` oldCols
    calcCol i = i `mod` oldCols
    select r c =
      let i = absIdx r c
       in content matrix ! calcRow i ! calcCol i

row :: Int -> Matrix a -> Vector a
row x matrix = content matrix ! (x - 1)

shape :: Matrix a -> (Int, Int)
shape matrix = (rows matrix, cols matrix)

transpose :: Matrix a -> Matrix a
transpose matrix =
  Matrix
    { cols = rows matrix,
      rows = cols matrix,
      content = V.generate (cols matrix) (\col -> column (col + 1) matrix)
    }
