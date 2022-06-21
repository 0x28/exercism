module Base (Error (..), rebase) where

data Error a = InvalidInputBase | InvalidOutputBase | InvalidDigit a
  deriving (Show, Eq)

baseToInt :: Integral a => a -> [a] -> Either (Error a) a
baseToInt base = baseToInt' 0
  where
    baseToInt' num [] = Right num
    baseToInt' num (d : ds)
      | d < 0 || d >= base = Left $ InvalidDigit d
      | otherwise = baseToInt' (num * base + d) ds

intToBase :: Integral a => a -> a -> [a]
intToBase base num = intToBase' num []
  where
    intToBase' n res
      | n == 0 = res
      | otherwise = intToBase' (n `div` base) (n `mod` base : res)

rebase :: Integral a => a -> a -> [a] -> Either (Error a) [a]
rebase inputBase outputBase inputDigits
  | inputBase <= 1 = Left InvalidInputBase
  | outputBase <= 1 = Left InvalidOutputBase
  | otherwise = fmap (intToBase outputBase) num
  where
    num = baseToInt inputBase inputDigits
