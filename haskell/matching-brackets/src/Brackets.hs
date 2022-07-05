module Brackets (arePaired) where

arePaired :: String -> Bool
arePaired xs = paired [] $ filter (`elem` "()[]{}") xs
  where
    paired [] [] = True
    paired ('{' : bs) ('}' : cs) = paired bs cs
    paired ('[' : bs) (']' : cs) = paired bs cs
    paired ('(' : bs) (')' : cs) = paired bs cs
    paired bs (c : cs) = paired (c : bs) cs
    paired _ _ = False
