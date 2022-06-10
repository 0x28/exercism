module POV (fromPOV, tracePathBetween) where

import Data.List (find)
import Data.Tree (Tree (Node, rootLabel))

fromPOV :: Eq a => a -> Tree a -> Maybe (Tree a)
fromPOV x tree@(Node r sub)
  | x == r = Just tree
  | otherwise =
    do
      containingTree <- find (elem x) sub
      fromPOV x (swap tree containingTree)

tracePathBetween :: Eq a => a -> a -> Tree a -> Maybe [a]
tracePathBetween from to tree = tree' >>= pathTo
  where
    tree' = fromPOV from tree
    pathTo (Node n sub)
      | n == to = Just [to]
      | otherwise =
        do
          containingTree <- find (elem to) sub
          path <- pathTo containingTree
          return (n : path)

swap :: Eq a => Tree a -> Tree a -> Tree a
swap (Node p psubtrees) (Node n subtrees) = Node n (parent' : subtrees)
  where
    parent' = Node p $ filter (\s -> n /= rootLabel s) psubtrees
