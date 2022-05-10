module RunLength (decode, encode) where

import Data.Char (isDigit)

decode :: String -> String
decode [] = []
decode encodedText =
  let (digits, c : rest) = span isDigit encodedText
   in  replicate (if null digits then 1 else read digits) c ++ decode rest

encode :: String -> String
encode [] = []
encode s@(c : _) =
  runLength ++ c : encode suffix
  where
    (prefix, suffix) = span (== c) s
    num = length prefix
    runLength = if num == 1 then "" else show num
