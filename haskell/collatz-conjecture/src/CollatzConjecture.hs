module CollatzConjecture (collatz) where

collatz :: Integer -> Maybe Integer
collatz n
  | n > 0 =
    let loop iter num
          | num == 1  = iter
          | even num  = loop (iter+1) (num `div` 2)
          | otherwise = loop (iter+1) (num * 3 + 1)
    in Just (loop 0 n)
  | otherwise = Nothing
