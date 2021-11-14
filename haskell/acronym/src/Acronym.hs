module Acronym (abbreviate) where

import Data.Char

isAcro :: Char -> Char -> Bool
isAcro first second = elem first "-_ " && isAlpha second
                      || isLower first && isUpper second

abbreviate :: String -> String
abbreviate xs =
  let loop (f:s:rest) | isAcro f s = s : loop rest
      loop (_:s:rest)              = loop (s:rest)
      loop _                       = []
  in
    map toUpper $ loop (' ':xs)
