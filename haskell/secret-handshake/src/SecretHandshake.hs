module SecretHandshake (handshake) where

import Data.Bits
import Data.Maybe

bits :: Int -> [Int]
bits n = filter (testBit n) [0..finiteBitSize n]

bitToAction :: Int -> Maybe String
bitToAction 0 = Just "wink"
bitToAction 1 = Just "double blink"
bitToAction 2 = Just "close your eyes"
bitToAction 3 = Just "jump"
bitToAction _ = Nothing

handshake :: Int -> [String]
handshake n
  | testBit n 4 = reverse actions
  | otherwise = actions
  where actions = catMaybes (map bitToAction (bits n))
