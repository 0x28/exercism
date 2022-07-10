module Say (inEnglish) where

englishTens :: Integer -> Maybe String
englishTens n
  | n < 20 = Nothing
  | n < 30 = Just "twenty"
  | n < 40 = Just "thirty"
  | n < 50 = Just "forty"
  | n < 60 = Just "fifty"
  | n < 70 = Just "sixty"
  | n < 80 = Just "seventy"
  | n < 90 = Just "eighty"
  | n < 100 = Just "ninety"
  | otherwise = Nothing

inEnglish :: Integer -> Maybe String
inEnglish 0 = Just "zero"
inEnglish 1 = Just "one"
inEnglish 2 = Just "two"
inEnglish 3 = Just "three"
inEnglish 4 = Just "four"
inEnglish 5 = Just "five"
inEnglish 6 = Just "six"
inEnglish 7 = Just "seven"
inEnglish 8 = Just "eight"
inEnglish 9 = Just "nine"
inEnglish 10 = Just "ten"
inEnglish 11 = Just "eleven"
inEnglish 12 = Just "twelve"
inEnglish 13 = Just "thirteen"
inEnglish 15 = Just "fifteen"
inEnglish n
  | n >= 1000000000 = inEnglish' 1000000000 "billion" n
  | n >= 1000000 = inEnglish' 1000000 "million" n
  | n >= 1000 = inEnglish' 1000 "thousand" n
  | n >= 100 = inEnglish' 100 "hundred" n
  | n >= 20 =
    do
      tens <- englishTens n
      let restNum = n `mod` 10
      rest <- inEnglish restNum
      return $
        if restNum == 0
          then tens
          else tens ++ "-" ++ rest
  | n >= 14 = (++ "teen") <$> inEnglish (n - 10)
  | otherwise = Nothing
  where
    inEnglish' magnitude name num =
      do
        let (magNum, restNum) = divMod num magnitude
        mag <- inEnglish magNum
        rest <- inEnglish restNum
        return $
          if restNum == 0
            then mag ++ " " ++ name
            else mag ++ " " ++ name ++ " " ++ rest
