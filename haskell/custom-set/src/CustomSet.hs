module CustomSet
  ( delete,
    difference,
    empty,
    fromList,
    insert,
    intersection,
    isDisjointFrom,
    isSubsetOf,
    member,
    null,
    size,
    toList,
    union,
  )
where

import Prelude hiding (null)

data CustomSet a = Empty | Node (CustomSet a) a (CustomSet a)
  deriving (Show)

instance Ord a => Eq (CustomSet a) where
  setA == setB = commonElements == size setA && commonElements == size setB
    where
      commonElements = size $ intersection setA setB

instance Foldable CustomSet where
  foldr _ acc Empty = acc
  foldr fun acc (Node left x right) = foldr fun (fun x (foldr fun acc right)) left

filter :: Ord a => (a -> Bool) -> CustomSet a -> CustomSet a
filter p = foldr (\e s -> if p e then insert e s else s) Empty

delete :: Ord a => a -> CustomSet a -> CustomSet a
delete x = CustomSet.filter (/= x)

difference :: Ord a => CustomSet a -> CustomSet a -> CustomSet a
difference setA setB = CustomSet.filter (not . (`member` setB)) setA

empty :: CustomSet a
empty = Empty

fromList :: Ord a => [a] -> CustomSet a
fromList = foldr insert Empty

insert :: Ord a => a -> CustomSet a -> CustomSet a
insert x Empty = Node Empty x Empty
insert x set@(Node left v right)
  | x < v = Node (insert x left) v right
  | x > v = Node left v (insert x right)
  | otherwise = set

intersection :: Ord a => CustomSet a -> CustomSet a -> CustomSet a
intersection setA setB = CustomSet.filter (`member` setB) setA

isDisjointFrom :: Ord a => CustomSet a -> CustomSet a -> Bool
isDisjointFrom setA setB = Empty == intersection setA setB

isSubsetOf :: Ord a => CustomSet a -> CustomSet a -> Bool
isSubsetOf setA setB = setA == intersection setA setB

member :: Ord a => a -> CustomSet a -> Bool
member _ Empty = False
member x (Node left v right)
  | x < v = member x left
  | x > v = member x right
  | otherwise = x == v

null :: Ord a => CustomSet a -> Bool
null = (Empty ==)

size :: CustomSet a -> Int
size = foldr (const (+ 1)) 0

toList :: CustomSet a -> [a]
toList = foldr (:) []

union :: Ord a => CustomSet a -> CustomSet a -> CustomSet a
union = foldr insert
