{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-unused-top-binds #-}

module Person
  ( Address (..),
    Born (..),
    Name (..),
    Person (..),
    bornStreet,
    renameStreets,
    setBirthMonth,
    setCurrentStreet,
  )
where

import Control.Lens
import Data.Time.Calendar (Day, fromGregorian, toGregorian)

data Person = Person
  { _name :: Name,
    _born :: Born,
    _address :: Address
  }

data Name = Name
  { _foreNames :: String,
    _surName :: String
  }

data Born = Born
  { _bornAt :: Address,
    _bornOn :: Day
  }

data Address = Address
  { _street :: String,
    _houseNumber :: Int,
    _place :: String,
    _country :: String
  }

makeLenses ''Person
makeLenses ''Name
makeLenses ''Born
makeLenses ''Address

bornStreet :: Born -> String
bornStreet = view (bornAt . street)

setCurrentStreet :: String -> Person -> Person
setCurrentStreet = set (address . street)

setBirthMonth :: Int -> Person -> Person
setBirthMonth month = over (born . bornOn) setMonth
  where
    setMonth date = case toGregorian date of
      (year, _, day) -> fromGregorian year month day

renameStreets :: (String -> String) -> Person -> Person
renameStreets f = over (address . street) f . over (born . bornAt . street) f
