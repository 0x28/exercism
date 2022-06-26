module BankAccount
  ( BankAccount,
    closeAccount,
    getBalance,
    incrementBalance,
    openAccount,
  )
where

import Control.Concurrent.STM (atomically)
import Control.Concurrent.STM.TVar

type BankAccount = TVar (Maybe Integer)

closeAccount :: BankAccount -> IO ()
closeAccount account = atomically $ writeTVar account Nothing

getBalance :: BankAccount -> IO (Maybe Integer)
getBalance = readTVarIO

incrementBalance :: BankAccount -> Integer -> IO (Maybe Integer)
incrementBalance account amount = atomically $ do
  modifyTVar account (fmap (+ amount))
  readTVar account

openAccount :: IO BankAccount
openAccount = newTVarIO $ Just 0
