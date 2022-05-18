module Counting
  ( Color (..),
    territories,
    territoryFor,
  )
where

import Control.Monad (join)
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe (mapMaybe)
import Data.Set (Set)
import qualified Data.Set as Set

data Color = Black | White deriving (Eq, Ord, Show)

type Coord = (Int, Int)

type Board = Map Coord (Maybe Color)

territories :: [String] -> [(Set Coord, Maybe Color)]
territories board =
  let board' = parseBoard board
      territories' unspec
        | Map.null unspec = []
        | otherwise = region : territories' (Map.withoutKeys unspec $ fst region)
        where
          region = flood board' ((head . Map.keys) unspec)
   in territories' $ fst (Map.partition (== Nothing) board')

territoryFor :: [String] -> Coord -> Maybe (Set Coord, Maybe Color)
territoryFor board coord
  | Set.null territory = Nothing
  | otherwise = Just (territory, color)
  where
    (territory, color) = flood (parseBoard board) coord

parseColor :: Char -> Maybe Color
parseColor 'B' = Just Black
parseColor 'W' = Just White
parseColor _ = Nothing

parseBoard :: [String] -> Map Coord (Maybe Color)
parseBoard input =
  Map.fromList
    [ ((x, y), parseColor c)
      | (y, line) <- zip [1 ..] (map (zip [1 ..]) input),
        (x, c) <- line
    ]

belongsTo :: [Color] -> Maybe Color
belongsTo [] = Nothing
belongsTo (c : cs)
  | all (== c) cs = Just c
  | otherwise = Nothing

flood :: Board -> Coord -> (Set Coord, Maybe Color)
flood board coord =
  (region, belongsTo $ mapMaybe join player)
  where
    (region, player) = flooder Set.empty coord Set.empty []
    flooder expanded pos@(x, y) result colors =
      if Set.member pos expanded
        || Map.notMember pos board
        || tile /= Just Nothing
        then (result, tile : colors)
        else (right, c4)
      where
        tile = Map.lookup pos board
        (right, c4) = flooder expanded' (x + 1, y) (Set.insert pos left) c3
        (left, c3) = flooder expanded' (x - 1, y) (Set.insert pos up) c2
        (up, c2) = flooder expanded' (x, y + 1) (Set.insert pos down) c1
        (down, c1) = flooder expanded' (x, y -1) (Set.insert pos result) colors
        expanded' = Set.insert pos expanded
