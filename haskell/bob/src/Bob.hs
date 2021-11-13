{-# LANGUAGE OverloadedStrings #-}

module Bob (responseFor) where

import Data.Char
import qualified Data.Text as T
import Data.Text (Text)

isQuestion :: Text -> Bool
isQuestion = T.isSuffixOf "?" . T.strip

isLoud :: Text -> Bool
isLoud sentence =
  let s = (T.filter isAlpha sentence)
  in T.all (\c -> isUpper c) s && not (T.null s)

isSilence :: Text -> Bool
isSilence = T.all isSpace

responseFor :: Text -> Text
responseFor sentence
  | isQuestion sentence && isLoud sentence = "Calm down, I know what I'm doing!"
  | isQuestion sentence = "Sure."
  | isLoud sentence = "Whoa, chill out!"
  | isSilence sentence = "Fine. Be that way!"
  | otherwise = "Whatever."
