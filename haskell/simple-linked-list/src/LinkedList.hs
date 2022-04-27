module LinkedList
  ( LinkedList,
    datum,
    fromList,
    isNil,
    new,
    next,
    nil,
    reverseLinkedList,
    toList,
  )
where

import Data.Foldable (foldl')

data LinkedList a = Nil | Cons a (LinkedList a)
  deriving (Eq, Show)

instance Foldable LinkedList where
  foldr _ a Nil = a
  foldr f a (Cons left right) = f left (foldr f a right)

datum :: LinkedList a -> a
datum Nil = error "datum used on empty list!"
datum (Cons hd _) = hd

fromList :: [a] -> LinkedList a
fromList = foldr Cons Nil

isNil :: LinkedList a -> Bool
isNil Nil = True
isNil _ = False

new :: a -> LinkedList a -> LinkedList a
new = Cons

next :: LinkedList a -> LinkedList a
next (Cons _ rest) = rest
next Nil = error "next used on empty list!"

nil :: LinkedList a
nil = Nil

reverseLinkedList :: LinkedList a -> LinkedList a
reverseLinkedList = foldl' (flip Cons) Nil

toList :: LinkedList a -> [a]
toList Nil = []
toList (Cons hd rest) = hd : toList rest
