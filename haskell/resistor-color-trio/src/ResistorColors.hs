module ResistorColors (Color (..), Resistor (..), label, ohms) where

data Color
  = Black
  | Brown
  | Red
  | Orange
  | Yellow
  | Green
  | Blue
  | Violet
  | Grey
  | White
  deriving (Show, Enum, Bounded)

newtype Resistor = Resistor {bands :: (Color, Color, Color)}
  deriving (Show)

label :: Resistor -> String
label resistor = show scaled ++ ' ' : unit
  where
    (scaled, unit) = scale (ohms resistor)

scale :: Int -> (Int, String)
scale ohm
  | ohm > 1000000000 = (ohm `div` 1000000000, "gigaohms")
  | ohm > 1000000 = (ohm `div` 1000000, "megaohms")
  | ohm > 1000 = (ohm `div` 1000, "kiloohms")
  | otherwise = (ohm, "ohms")

ohms :: Resistor -> Int
ohms Resistor {bands = (a, b, c)} = (fromEnum a * 10 + fromEnum b) * 10 ^ fromEnum c
