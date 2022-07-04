module Roman (numerals) where

numerals :: Integer -> Maybe String
numerals n
  | n > 0 = Just $ roman n
  | otherwise = Nothing

roman :: Integer -> String
roman n
  | n >= 1000 = 'M' : roman (n - 1000)
  | n >= 900 = 'C' : 'M' : roman (n - 900)
  | n >= 500 = 'D' : roman (n - 500)
  | n >= 400 = 'C' : 'D' : roman (n - 400)
  | n >= 100 = 'C' : roman (n - 100)
  | n >= 90 = 'X' : 'C' : roman (n - 90)
  | n >= 50 = 'L' : roman (n - 50)
  | n >= 40 = 'X' : 'L' : roman (n - 40)
  | n >= 10 = 'X' : roman (n - 10)
  | n == 9 = "IX"
  | n >= 5 = 'V' : roman (n - 5)
  | n == 4 = "IV"
  | n <= 0 = ""
  | otherwise = 'I' : roman (n - 1)
