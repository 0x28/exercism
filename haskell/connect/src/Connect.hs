module Connect (Mark (..), winner) where

import Data.Char (isSpace)
import Data.Map (Map)
import qualified Data.Map as M
import Data.Maybe (catMaybes)
import Data.Set (Set)
import qualified Data.Set as S

data Mark = Cross | Nought deriving (Eq, Show, Ord)

type Pos = (Int, Int)

data Board = Board {width :: Int, height :: Int, content :: Map Pos Mark}
  deriving (Eq, Show)

winner :: [String] -> Maybe Mark
winner board
  | any xWins $ S.map (flood board') left = Just Cross
  | any oWins $ S.map (flood board') top = Just Nought
  | otherwise = Nothing
  where
    board' = parseBoard board
    fields = content board'
    top = M.keysSet $ M.filterWithKey (\(_, y) m -> y == 0 && m == Nought) fields
    left = M.keysSet $ M.filterWithKey (\(x, _) m -> x == 0 && m == Cross) fields
    xWins = any (\(x, _) -> x + 1 == width board')
    oWins = any (\(_, y) -> y + 1 == height board')

flood :: Board -> Pos -> Set Pos
flood board pos = flood' pos S.empty S.empty
  where
    flood' pos' expanded seen
      | S.member pos' expanded = seen
      | otherwise =
        let adjacent = neighbors board pos'
            expanded' = S.insert pos' expanded
         in foldr (\n s -> flood' n expanded' $ S.insert n s) seen adjacent

neighbors :: Board -> Pos -> Set Pos
neighbors Board {content = board} start@(x, y) =
  S.fromList $
    catMaybes
      [ element (x, y),
        element (x + 1, y),
        element (x - 1, y),
        element (x, y + 1),
        element (x, y - 1),
        element (x + 1, y - 1),
        element (x - 1, y + 1)
      ]
  where
    mark = M.lookup start board
    element pos = case (M.lookup pos board, mark) of
      (Just a, Just b) -> if a == b then Just pos else Nothing
      _ -> Nothing

parseBoard :: [String] -> Board
parseBoard [] = error "Invalid board!"
parseBoard ls =
  Board
    { width = length $ removeNoise $ head ls,
      height = length ls,
      content =
        M.fromList
          [ ((x, y), parseMark char)
            | (y, line) <- zip [0 ..] ls,
              (x, char) <- zip [0 ..] $ removeNoise line,
              char `elem` "XO"
          ]
    }
  where
    removeNoise = filter (not . isSpace)
    parseMark 'X' = Cross
    parseMark 'O' = Nought
    parseMark c = error $ "Unknown char" ++ show c
