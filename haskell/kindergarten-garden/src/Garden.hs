module Garden (Plant (..), garden, lookupPlants) where

import Data.Maybe (fromMaybe)

data Plant = Clover | Grass | Radishes | Violets deriving (Eq, Show)

type Garden = [(String, [Plant])]

pots :: String -> [[Plant]]
pots plants = group (map plant first) (map plant second)
  where
    (first : second : _) = lines plants
    group (a : b : cs) (x : y : zs) = [a, b, x, y] : group cs zs
    group _ _ = []
    plant 'C' = Clover
    plant 'G' = Grass
    plant 'R' = Radishes
    plant 'V' = Violets
    plant c = error $ "Unknown plant" ++ show c

garden :: [String] -> String -> Garden
garden students plants = zip students $ pots plants

lookupPlants :: String -> Garden -> [Plant]
lookupPlants student g = fromMaybe [] $ lookup student g
