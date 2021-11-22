module BST
    ( BST
    , bstLeft
    , bstRight
    , bstValue
    , empty
    , fromList
    , insert
    , singleton
    , toList
    ) where

import Data.Foldable (foldl')

data BST a = Leaf
             | Node (BST a) a (BST a) deriving (Eq, Show)

instance Foldable BST where
  foldr _ a Leaf = a
  foldr f a (Node left v right) = foldr f (f v (foldr f a right)) left

bstLeft :: BST a -> Maybe (BST a)
bstLeft (Node left _ _) = Just left
bstLeft Leaf = Nothing

bstRight :: BST a -> Maybe (BST a)
bstRight (Node _ _ right) = Just right
bstRight Leaf = Nothing

bstValue :: BST a -> Maybe a
bstValue (Node _ value _) = Just value
bstValue Leaf = Nothing

empty :: BST a
empty = Leaf

fromList :: Ord a => [a] -> BST a
fromList xs = foldl' (\t x -> insert x t) Leaf xs

insert :: Ord a => a -> BST a -> BST a
insert x Leaf = singleton x
insert x (Node left v right)
  | x <= v = Node (insert x left) v right
  | otherwise = Node left v (insert x right)

singleton :: a -> BST a
singleton x = Node Leaf x Leaf

toList :: BST a -> [a]
toList = foldr (:) []
