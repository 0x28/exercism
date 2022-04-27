module WordProblem (answer) where

import Text.ParserCombinators.Parsec
import Text.ParserCombinators.Parsec.Token (integer)
import Text.ParserCombinators.Parsec.Language (haskell)

answer :: String -> Maybe Integer
answer problem = either (const Nothing) Just result
  where
    result = parse question "input" problem

question :: Parser Integer
question = do
  string "What is" *> spaces
  num <- expr <* string "?"
  spaces
  return num

number :: Parser Integer
number = integer haskell

expr :: Parser Integer
expr = number `chainl1` operation

operation :: Parser (Integer -> Integer -> Integer)
operation = try (binOp "plus" (+))
  <|> try (binOp "minus" (-))
  <|> try (binOp "divided by" div)
  <|> try (binOp "multiplied by" (*))

type BinaryOperation = (Integer -> Integer -> Integer)

binOp :: String -> BinaryOperation -> Parser BinaryOperation
binOp tok op =
  do
    string tok *> spaces
    return op
