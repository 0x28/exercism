module Meetup (Weekday (..), Schedule (..), meetupDay) where

import qualified Data.Time as T
import Data.Time.Calendar (Day, fromGregorian)

data Weekday = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday

data Schedule = First | Second | Third | Fourth | Last | Teenth

weekdayToDayOfWeek :: Weekday -> T.DayOfWeek
weekdayToDayOfWeek Monday = T.Monday
weekdayToDayOfWeek Tuesday = T.Tuesday
weekdayToDayOfWeek Wednesday = T.Wednesday
weekdayToDayOfWeek Thursday = T.Thursday
weekdayToDayOfWeek Friday = T.Friday
weekdayToDayOfWeek Saturday = T.Saturday
weekdayToDayOfWeek Sunday = T.Sunday

findWeekday :: Integer -> T.DayOfWeek -> Day -> Day
findWeekday increment dayOfWeek day
  | T.dayOfWeek day == dayOfWeek = day
  | otherwise = findWeekday increment dayOfWeek (T.addDays increment day)

meetupDay :: Schedule -> Weekday -> Integer -> Int -> Day
meetupDay schedule weekday year month =
  case schedule of
    Teenth -> nextWeekday wd $ fromGregorian year month 13
    First -> nextWeekday wd $ fromGregorian year month 1
    Second -> nextWeekday wd $ T.addDays 1 $ meetupDay First weekday year month
    Third -> nextWeekday wd $ T.addDays 1 $ meetupDay Second weekday year month
    Fourth -> nextWeekday wd $ T.addDays 1 $ meetupDay Third weekday year month
    Last -> prevWeekday wd $ fromGregorian year month 31
  where
    wd = weekdayToDayOfWeek weekday
    nextWeekday = findWeekday 1
    prevWeekday = findWeekday (-1)
