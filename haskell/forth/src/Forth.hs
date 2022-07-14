{-# LANGUAGE OverloadedStrings #-}

module Forth (ForthError (..), ForthState, evalText, toList, emptyState) where

import Data.Char (isNumber, toLower)
import Data.Map (Map)
import qualified Data.Map as M
import Data.Maybe (fromJust, isJust)
import Data.Text (Text)
import qualified Data.Text as T

data ForthError
  = DivisionByZero
  | StackUnderflow
  | InvalidWord
  | UnknownWord Text
  deriving (Show, Eq)

type ForthState = (Map Text [ForthValue], [Int])

data ForthValue = Number Int | Symbol Text deriving (Show, Eq)

parseToken :: Text -> ForthValue
parseToken token
  | T.all isNumber token = Number $ read $ T.unpack token
  | otherwise = Symbol $ T.map toLower token

emptyState :: ForthState
emptyState = (M.empty, [])

evalText :: Text -> ForthState -> Either ForthError ForthState
evalText text = eval $ parseToken <$> T.words text

resolve :: Map Text [ForthValue] -> [ForthValue] -> [ForthValue]
resolve _ [] = []
resolve vars (Number n : expr) = Number n : resolve vars expr
resolve vars (Symbol s : expr) = case M.lookup s vars of
  Just def -> def ++ resolve vars expr
  Nothing -> Symbol s : resolve vars expr

isBuiltin :: Text -> Bool
isBuiltin sym = sym `elem` ["dup", "drop", "swap", "over", "+", "-", "/", "*"]

eval :: [ForthValue] -> ForthState -> Either ForthError ForthState
eval [] result = Right result
eval (Number n : os) (vars, es) = eval os (vars, n : es)
eval (Symbol s : os) (vars, es)
  | isJust def = eval (fromJust def ++ os) (vars, es)
  where
    def = M.lookup s vars
eval (Symbol ":" : Number _ : _) (_, _) = Left InvalidWord
eval (Symbol ":" : os) (vars, es) = eval rest (newVars, es)
  where
    newVars = M.insert s (resolve vars definition) vars
    (Symbol s : definition, Symbol ";" : rest) = span (/= Symbol ";") os
eval (Symbol "dup" : os) (vars, e : es) = eval os (vars, e : e : es)
eval (Symbol "drop" : os) (vars, _ : es) = eval os (vars, es)
eval (Symbol "swap" : os) (vars, e1 : e2 : es) = eval os (vars, e2 : e1 : es)
eval (Symbol "over" : os) (vars, e1 : e2 : es) = eval os (vars, e2 : e1 : e2 : es)
eval (Symbol "+" : os) (vars, e1 : e2 : es) = eval os (vars, (e2 + e1) : es)
eval (Symbol "-" : os) (vars, e1 : e2 : es) = eval os (vars, (e2 - e1) : es)
eval (Symbol "*" : os) (vars, e1 : e2 : es) = eval os (vars, (e2 * e1) : es)
eval (Symbol "/" : _) (_, 0 : _ : _) = Left DivisionByZero
eval (Symbol "/" : os) (vars, e1 : e2 : es) = eval os (vars, (e2 `div` e1) : es)
eval (Symbol s : _) (vars, _)
  | M.notMember s vars && not (isBuiltin s) = Left $ UnknownWord s
  | otherwise = Left StackUnderflow

toList :: ForthState -> [Int]
toList = reverse . snd
