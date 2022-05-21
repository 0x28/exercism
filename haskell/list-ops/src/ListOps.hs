module ListOps (length, reverse, map, filter, foldr, foldl', (++), concat) where

import Prelude hiding (concat, filter, foldr, length, map, reverse, (++))

foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' _ z [] = z
foldl' f z (x : xs) = acc `seq` foldl' f acc xs
  where
    acc = f z x

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr _ z [] = z
foldr f z (x : xs) = f x (foldr f z xs)

length :: [a] -> Int
length = foldr (\_ acc -> acc + 1) 0

reverse :: [a] -> [a]
reverse = foldl' (flip (:)) []

map :: (a -> b) -> [a] -> [b]
map f = foldr (\e l -> f e : l) []

filter :: (a -> Bool) -> [a] -> [a]
filter p = foldr (\e l -> if p e then e : l else l) []

(++) :: [a] -> [a] -> [a]
xs ++ ys = foldr (:) ys xs

concat :: [[a]] -> [a]
concat = foldr (++) []
