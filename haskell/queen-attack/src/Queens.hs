module Queens (boardString, canAttack) where

boardString :: Maybe (Int, Int) -> Maybe (Int, Int) -> String
boardString white black =
  concat [[field, sep] | row <- [0..7], col <- [0..7]
                       , let sep = if col == 7 then '\n' else ' '
                             field = case Just (row, col) of
                               pos | pos == white -> 'W'
                               pos | pos == black -> 'B'
                               _                  -> '_'
         ]

canAttack :: (Int, Int) -> (Int, Int) -> Bool
canAttack (aRow, aCol) (bRow, bCol) =
  aRow == bRow ||
  aCol == bCol ||
  abs (aRow - bRow) == abs (aCol - bCol)
