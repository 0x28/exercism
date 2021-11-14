module Clock (addDelta, fromHourMin, toString) where

import Text.Printf (printf)

data Clock = Time Int
  deriving Eq

minutesInDay :: Int
minutesInDay = 60 * 24

hoursToMinutes :: Int -> Int
hoursToMinutes h = h * 60

clockMinutes :: Clock -> Int
clockMinutes (Time m) = m `mod` 60

clockHours :: Clock -> Int
clockHours (Time m) = (m `div` 60) `mod` 24

fromHourMin :: Int -> Int -> Clock
fromHourMin hour minute =
  Time $ (hoursToMinutes hour + minute) `mod` minutesInDay

toString :: Clock -> String
toString clock = printf "%02d:%02d" (clockHours clock) (clockMinutes clock)

addDelta :: Int -> Int -> Clock -> Clock
addDelta hour minute (Time old)=
  Time $ (old + hoursToMinutes hour + minute) `mod` minutesInDay
