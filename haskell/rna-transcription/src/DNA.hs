module DNA (toRNA) where

translateNucleotide :: Char -> Either Char Char
translateNucleotide c =
  case c of
    'G' -> Right 'C'
    'C' -> Right 'G'
    'T' -> Right 'A'
    'A' -> Right 'U'
    x   -> Left x

toRNA :: String -> Either Char String
toRNA [] = Right []
toRNA (x : xs) = do
  rna <- translateNucleotide x
  rest <- toRNA xs
  return (rna : rest)
