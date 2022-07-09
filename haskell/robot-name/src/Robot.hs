module Robot (Robot, initialState, mkRobot, resetName, robotName) where

import Control.Monad.State (StateT, get, liftIO, put)
import Data.IORef
import Data.Set (Set)
import qualified Data.Set as S
import System.Random

type Robot = IORef String

type RunState = Set String

initialState :: RunState
initialState = S.empty

mkRobot :: StateT RunState IO Robot
mkRobot = do
  robotNames <- get
  l <- liftIO $ randomRs ('A', 'Z') <$> newStdGen
  d <- liftIO $ randomRs ('0', '9') <$> newStdGen
  let name = take 2 l ++ take 3 d
  robot <- liftIO $ newIORef name
  if S.member name robotNames
    then mkRobot
    else do
      put (S.insert name robotNames)
      return robot

resetName :: Robot -> StateT RunState IO ()
resetName robot = do
  newName <- readIORef <$> mkRobot
  oldName <- liftIO $ readIORef robot
  _ <- liftIO $ do
    newName' <- newName
    writeIORef robot newName'
  robotNames <- get
  put (S.delete oldName robotNames)
  return ()

robotName :: Robot -> IO String
robotName = readIORef
