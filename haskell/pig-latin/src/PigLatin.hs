module PigLatin (translate) where

import Data.Char (isAlpha)
import Data.List (isPrefixOf)

isVowel :: Char -> Bool
isVowel c = c `elem` "aeiou"

isConsonant :: Char -> Bool
isConsonant c = isAlpha c && not (isVowel c)

consonantCluster :: String -> (String, String)
consonantCluster [] = ([], [])
consonantCluster word@(c : cs)
  | "qu" `isPrefixOf` word = ("qu", drop 2 word)
  | c == 'y' = ("", 'y' : cs)
  | isConsonant c = (c : p, r)
  | otherwise = ("", word)
  where
    (p, r) = consonantCluster cs

translate :: String -> String
translate xs = unwords $ map translate' $ words xs

translate' :: String -> String
translate' [] = []
translate' word@(x : xs)
  | isVowel x = word ++ "ay"
  | "yt" `isPrefixOf` word = word ++ "ay"
  | "xr" `isPrefixOf` word = word ++ "ay"
  | p /= "" = r ++ p ++ "ay"
  | otherwise = xs ++ (x : "ay")
  where
    (p, r) = consonantCluster word
