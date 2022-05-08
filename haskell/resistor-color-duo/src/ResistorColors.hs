module ResistorColors (Color (..), value) where

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
  deriving (Eq, Show, Enum, Bounded)

value :: (Color, Color) -> Int
value (a, b) = decode a * 10 + decode b

decode :: Color -> Int
decode Black = 0
decode Brown = 1
decode Red = 2
decode Orange = 3
decode Yellow = 4
decode Green = 5
decode Blue = 6
decode Violet = 7
decode Grey = 8
decode White = 9
