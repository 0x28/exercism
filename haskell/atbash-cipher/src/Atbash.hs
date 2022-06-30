module Atbash (decode, encode) where

import Data.Char (chr, isAlpha, ord, toLower, isAlphaNum)
import qualified Data.Text as T
import Data.Text (Text)

subst :: Char -> Char
subst c
  | isAlpha  lower = chr $ ord 'z' - ord lower + ord 'a'
  | otherwise = lower
  where
    lower = toLower c

decode :: Text -> Text
decode = T.map subst . T.filter isAlphaNum

encode :: Text -> Text
encode plainText = T.unwords $ T.chunksOf 5 $ decode plainText
