module Cipher (caesarDecode, caesarEncode, caesarEncodeRandom) where

import Data.Char (chr, ord)
import System.Random

caesarDecode :: String -> String -> String
caesarDecode key = zipWith (keyShift (-)) $ cycle key

caesarEncode :: String -> String -> String
caesarEncode key = zipWith (keyShift (+)) $ cycle key

keyShift :: (Int -> Int -> Int) -> Char -> Char -> Char
keyShift dir k c = chr $ offset + ((ord c - offset) `dir` (ord k - offset)) `mod` 26
  where
    offset = ord 'a'

randomKey :: IO String
randomKey = randomRs ('a', 'z') <$> newStdGen

caesarEncodeRandom :: String -> IO (String, String)
caesarEncodeRandom text = do
  key <- randomKey
  return (key, caesarEncode key text)
