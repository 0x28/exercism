module ReverseString (reverseString) where

reverseString :: String -> String
reverseString str = go str []
  where
    go [] acc = acc
    go (c : cs) acc = go cs (c : acc)
