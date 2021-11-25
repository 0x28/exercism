module Robot
    ( Bearing(East,North,South,West)
    , bearing
    , coordinates
    , mkRobot
    , move
    ) where

import Data.Foldable (foldl')

data Bearing = North
             | East
             | South
             | West
             deriving (Eq, Show)

left :: Bearing -> Bearing
left North = West
left East = North
left South = East
left West = South

right :: Bearing -> Bearing
right North = East
right East = South
right South = West
right West = North

data Robot = Robot {coordinates :: (Integer, Integer), bearing :: Bearing}
  deriving (Eq, Show)

mkRobot :: Bearing -> (Integer, Integer) -> Robot
mkRobot direction pos =
  Robot { coordinates = pos, bearing = direction }

advance :: Bearing -> (Integer, Integer) -> (Integer, Integer)
advance North (x,y) = (x,y+1)
advance East  (x,y) = (x+1,y)
advance South (x,y) = (x,y-1)
advance West  (x,y) = (x-1,y)

moveBy :: Robot -> Char -> Robot
moveBy Robot { coordinates = pos, bearing = dir } operation
  | operation == 'L' = mkRobot (left dir) pos
  | operation == 'R' = mkRobot (right dir) pos
  | operation == 'A' = mkRobot dir (advance dir pos)
  | otherwise = mkRobot dir pos

move :: Robot -> String -> Robot
move robot instructions = foldl' moveBy robot instructions
