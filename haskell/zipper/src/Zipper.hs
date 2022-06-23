module Zipper
  ( BinTree (BT),
    fromTree,
    left,
    right,
    setLeft,
    setRight,
    setValue,
    toTree,
    up,
    value,
  )
where

data BinTree a = BT
  { btValue :: a,
    btLeft :: Maybe (BinTree a),
    btRight :: Maybe (BinTree a)
  }
  deriving (Eq, Show)

data Zipper a = Zipper
  { focus :: BinTree a,
    hist :: [(ZipperDir, a, Maybe (BinTree a))]
  }
  deriving (Eq, Show)

data ZipperDir = L | R deriving (Eq, Show)

fromTree :: BinTree a -> Zipper a
fromTree tree = Zipper tree []

toTree :: Zipper a -> BinTree a
toTree z@(Zipper f _) = maybe f toTree $ up z

value :: Zipper a -> a
value (Zipper (BT v _ _) _) = v

left :: Zipper a -> Maybe (Zipper a)
left (Zipper (BT _ Nothing _) _) = Nothing
left (Zipper (BT v (Just l) r) hs) = Just $ Zipper l ((R, v, r) : hs)

right :: Zipper a -> Maybe (Zipper a)
right (Zipper (BT _ _ Nothing) _) = Nothing
right (Zipper (BT v l (Just r)) hs) = Just $ Zipper r ((L, v, l) : hs)

up :: Zipper a -> Maybe (Zipper a)
up (Zipper _ []) = Nothing
up (Zipper tree (h : hs)) =
  case h of
    (L, v, l) -> Just $ Zipper (BT v l (Just tree)) hs
    (R, v, r) -> Just $ Zipper (BT v (Just tree) r) hs

setValue :: a -> Zipper a -> Zipper a
setValue x (Zipper (BT _ l r) hs) = Zipper (BT x l r) hs

setLeft :: Maybe (BinTree a) -> Zipper a -> Zipper a
setLeft tree (Zipper (BT v _ r) hs) = Zipper (BT v tree r) hs

setRight :: Maybe (BinTree a) -> Zipper a -> Zipper a
setRight tree (Zipper (BT v l _) hs) = Zipper (BT v l tree) hs
