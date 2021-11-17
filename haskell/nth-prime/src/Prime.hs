module Prime (nth) where

sieve :: Integral i => [i] -> [i]
sieve (p:xs) = p : sieve (filter (\n -> n `mod` p /= 0) xs)

nth :: Int -> Maybe Integer
nth 0 = Nothing
nth n = Just (sieve [2..] !! pred n)
