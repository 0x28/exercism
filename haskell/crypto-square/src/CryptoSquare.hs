module CryptoSquare (encode) where

import Data.Char
import Data.List

chunks :: Int -> [a] -> [[a]]
chunks _ [] = []
chunks n xs = take n xs : chunks n (drop n xs)

normalize :: String -> String
normalize = filter isAlphaNum . map toLower

padRight :: Int -> String -> String
padRight n xs = take n $ (xs ++ repeat ' ')

encode :: String -> String
encode xs =
  intercalate " " $ transpose $ map (padRight c) $ chunks c nxs
  where
    nxs = normalize xs
    c = ceiling $ sqrt $ fromIntegral (length nxs)
