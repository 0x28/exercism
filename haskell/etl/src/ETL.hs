module ETL (transform) where

import Data.Char (toLower)
import Data.Map (Map, foldrWithKey, insert)

transform :: Map a String -> Map Char a
transform = foldrWithKey translate mempty
  where
    translate score str m = foldr ((`insert` score) . toLower) m str
