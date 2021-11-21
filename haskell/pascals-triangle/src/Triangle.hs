module Triangle (rows) where

pairs :: (Eq a, Num a) => [a] -> [[a]]
pairs (f:s:rest) = [f,s] : pairs (s:rest)
pairs [1] = [[1,0]]
pairs _ = undefined

pascal :: [Integer] -> [[Integer]]
pascal prev = row : pascal row
  where row = 1 : map sum (pairs prev)

rows :: Int -> [[Integer]]
rows x = take x ([1] : pascal [1])
