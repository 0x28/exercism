module Sgf (parseSgf) where

import Data.Char (isSpace)
import Data.Map (Map)
import qualified Data.Map as M
import Data.Text (Text)
import qualified Data.Text as T
import Data.Tree (Tree (Node))
import Text.Parsec.Combinator
import Text.Parsec.Prim
import Text.Parsec.Text
import Text.ParserCombinators.Parsec (anyChar, char, noneOf, upper)

type SgfNode = Map Text [Text]

type SgfTree = Tree SgfNode

value :: Parser Text
value = do
  v <-
    many1 $
      char '\\' *> anyChar
        <|> (noneOf "[]" >>= (\c -> return $ if isSpace c then ' ' else c))
  return $ T.pack $ filter (/= '\n') v

property :: Parser (Text, [Text])
property = do
  key <- many1 upper
  values <- many1 (char '[' *> value <* char ']')
  return (T.pack key, values)

node :: Parser SgfNode
node = do
  ps <- char ';' *> many property
  return (M.fromList ps)

tree :: Parser SgfTree
tree = do
  n <- node
  c <- many (tree <|> sgf)
  return $ Node n c

sgf :: Parser SgfTree
sgf = char '(' *> tree <* char ')'

parseSgf :: Text -> Maybe (Tree (Map Text [Text]))
parseSgf input = either (const Nothing) Just $ parse sgf "input" input
