module DNA (nucleotideCounts, Nucleotide(..)) where

import Data.Map (Map)
import qualified Data.Map as Map

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

incCount :: Int -> Int -> Int
incCount _ old = succ old

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts xs =
  let loop dna dnaMap =
        case dna of
          []       -> Right dnaMap
          'A':rest -> loop rest (Map.insertWith incCount A 1 dnaMap)
          'C':rest -> loop rest (Map.insertWith incCount C 1 dnaMap)
          'G':rest -> loop rest (Map.insertWith incCount G 1 dnaMap)
          'T':rest -> loop rest (Map.insertWith incCount T 1 dnaMap)
          _:_      -> Left "invalid DNA"
  in
    loop xs Map.empty
