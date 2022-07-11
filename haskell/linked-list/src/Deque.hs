module Deque (Deque, mkDeque, pop, push, shift, unshift) where

import Data.IORef
import Data.Maybe (fromJust)

newtype Node a = Node (IORef (Maybe (Node a), a, Maybe (Node a)))

type Deque a = IORef (Maybe (Node a, Node a))

left :: Node a -> IO (Maybe (Node a))
left (Node ref) = do
  (l, _, _) <- readIORef ref
  return l

right :: Node a -> IO (Maybe (Node a))
right (Node ref) = do
  (_, _, r) <- readIORef ref
  return r

value :: Node a -> IO a
value (Node ref) = do
  (_, v, _) <- readIORef ref
  return v

setLeft :: Node a -> Maybe (Node a) -> IO ()
setLeft (Node n) newLeft = do
  (_, v, r) <- readIORef n
  writeIORef n (newLeft, v, r)

setRight :: Node a -> Maybe (Node a) -> IO ()
setRight (Node n) newRight = do
  (l, v, _) <- readIORef n
  writeIORef n (l, v, newRight)

mkDeque :: IO (Deque a)
mkDeque = newIORef Nothing

pop :: Deque a -> IO (Maybe a)
pop deque = do
  (begin, end) <- fromJust <$> readIORef deque
  l <- left end
  case l of
    Just node -> do
      setRight node Nothing
      writeIORef deque (Just (begin, node))
    Nothing -> do
      writeIORef deque Nothing
  Just <$> value end

push :: Deque a -> a -> IO ()
push deque x = do
  dq <- readIORef deque
  case dq of
    Just (begin, end) -> do
      new <- Node <$> newIORef (Just end, x, Nothing)
      setRight end (Just new)
      writeIORef deque $ Just (begin, new)
    Nothing -> do
      new <- newIORef (Nothing, x, Nothing)
      writeIORef deque $ Just (Node new, Node new)
  return ()

unshift :: Deque a -> a -> IO ()
unshift deque x = do
  dq <- readIORef deque
  case dq of
    Just (begin, end) -> do
      new <- Node <$> newIORef (Nothing, x, Just begin)
      setLeft begin (Just new)
      writeIORef deque $ Just (new, end)
    Nothing -> do
      new <- newIORef (Nothing, x, Nothing)
      writeIORef deque $ Just (Node new, Node new)
  return ()

shift :: Deque a -> IO (Maybe a)
shift deque = do
  (begin, end) <- fromJust <$> readIORef deque
  r <- right begin
  case r of
    Just node -> do
      setLeft node Nothing
      writeIORef deque (Just (node, end))
    Nothing -> do
      writeIORef deque Nothing
  Just <$> value begin
