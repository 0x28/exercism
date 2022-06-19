module ArmstrongNumbers (armstrong) where

import Data.Char (digitToInt)

armstrong :: (Show a, Integral a) => a -> Bool
armstrong n = fromIntegral n == sum (map (^ length digits) digits)
  where
    digits = map digitToInt $ show n
