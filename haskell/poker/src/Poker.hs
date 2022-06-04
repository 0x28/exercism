{-# LANGUAGE TupleSections #-}

module Poker (bestHands) where

import Data.Char (digitToInt)
import Data.List (maximumBy, sortBy)

data Suit = Heart | Diamond | Club | Spade
  deriving (Eq, Show)

data CardCategory
  = StraightFlush Int
  | Four Int
  | FullHouse Int
  | Flush Int
  | Straight Int
  | Three Int
  | TwoPair Int Int
  | OnePair Int
  | HighCard Int
  deriving (Eq, Show)

type Card = (Suit, Int)

type Hand = (Card, Card, Card, Card, Card)

bestHands :: [String] -> Maybe [String]
bestHands input =
  do
    hands <- mapM readHand input
    let (best, _) = maximumBy cmp hands
    return $ snd <$> filter (\(h, _) -> compareHands best h == EQ) hands
  where
    cmp (h1, _) (h2, _) = compareHands h1 h2

compareHands :: Hand -> Hand -> Ordering
compareHands h1 h2 = case (categorize h1, categorize h2) of
  (StraightFlush a, StraightFlush b) -> compare a b
  (StraightFlush _, _) -> GT
  (_, StraightFlush _) -> LT
  (Four a, Four b)
    | a == b -> tieBreak
    | otherwise -> compare a b
  (Four _, _) -> GT
  (_, Four _) -> LT
  (FullHouse a, FullHouse b)
    | a == b -> tieBreak
    | otherwise -> compare a b
  (FullHouse _, _) -> GT
  (_, FullHouse _) -> LT
  (Flush a, Flush b) -> compare a b
  (Flush _, _) -> GT
  (_, Flush _) -> LT
  (Straight a, Straight b) -> compare a b
  (Straight _, _) -> GT
  (_, Straight _) -> LT
  (Three a, Three b)
    | a == b -> tieBreak
    | otherwise -> compare a b
  (Three _, _) -> GT
  (_, Three _) -> LT
  (TwoPair a a', TwoPair b b')
    | a == b && a' == b' -> tieBreak
    | a == b -> compare a' b'
    | otherwise -> compare a b
  (TwoPair _ _, _) -> GT
  (_, TwoPair _ _) -> LT
  (OnePair a, OnePair b)
    | a == b -> tieBreak
    | otherwise -> compare a b
  (OnePair _, _) -> GT
  (_, OnePair _) -> LT
  (HighCard a, HighCard b)
    | a == b -> tieBreak
    | otherwise -> compare a b
  where
    tieBreak = compare (cardSum h1) (cardSum h2)

cardSum :: Hand -> Int
cardSum ((_, v1), (_, v2), (_, v3), (_, v4), (_, v5)) = sum [v1, v2, v3, v4, v5]

categorize :: Hand -> CardCategory
categorize ((s1, v1), (s2, v2), (s3, v3), (s4, v4), (s5, v5))
  | isFlush s1 s2 s3 s4 s5 && isStraight v1 v2 v3 v4 v5 = StraightFlush v1
  | isFlush s1 s2 s3 s4 s5 && isStraightAce v1 v2 v3 v4 v5 = StraightFlush v5
  | v1 == v2 && v2 == v3 && v3 == v4 = Four v1
  | v2 == v3 && v3 == v4 && v4 == v5 = Four v2
  | v1 == v2 && v2 == v3 && v4 == v5 = FullHouse v1
  | v1 == v2 && v3 == v4 && v4 == v5 = FullHouse v3
  | isFlush s1 s2 s3 s4 s5 = Flush v1
  | isStraight v1 v2 v3 v4 v5 = Straight v1
  | isStraightAce v1 v2 v3 v4 v5 = Straight v5
  | v1 == v2 && v2 == v3 = Three v1
  | v2 == v3 && v3 == v4 = Three v2
  | v3 == v4 && v4 == v5 = Three v3
  | v1 == v2 && v3 == v4 = TwoPair v1 v3
  | v1 == v2 && v4 == v5 = TwoPair v1 v4
  | v2 == v3 && v4 == v5 = TwoPair v2 v4
  | v1 == v2 = OnePair v1
  | v2 == v3 = OnePair v2
  | v3 == v4 = OnePair v3
  | v4 == v5 = OnePair v4
  | otherwise = HighCard v1
  where
    isFlush a b c d e = a == b && b == c && c == d && d == e
    isStraightAce a b c d e = a == 14 && b == 5 && c == 4 && d == 3 && e == 2
    isStraight a b c d e = a == b + 1 && b == c + 1 && c == d + 1 && d == e + 1

readHand :: String -> Maybe (Hand, String)
readHand input = (,input) <$> hand cards
  where
    hand (Just [c1, c2, c3, c4, c5]) = Just (c1, c2, c3, c4, c5)
    hand _ = Nothing
    cards = sortBy (\(_, v1) (_, v2) -> compare v2 v1) <$> mapM readCard (words input)
    readSuit 'S' = Just Spade
    readSuit 'C' = Just Club
    readSuit 'H' = Just Heart
    readSuit 'D' = Just Diamond
    readSuit _ = Nothing
    readCard ['A', suit] = (,14) <$> readSuit suit
    readCard ['K', suit] = (,13) <$> readSuit suit
    readCard ['Q', suit] = (,12) <$> readSuit suit
    readCard ['J', suit] = (,11) <$> readSuit suit
    readCard ['1', '0', suit] = (,10) <$> readSuit suit
    readCard [n, suit] = (,digitToInt n) <$> readSuit suit
    readCard _ = Nothing
