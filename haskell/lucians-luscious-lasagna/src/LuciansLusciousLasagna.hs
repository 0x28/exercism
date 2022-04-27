module LuciansLusciousLasagna
  ( elapsedTimeInMinutes,
    expectedMinutesInOven,
    preparationTimeInMinutes,
  )
where

expectedMinutesInOven :: Int
expectedMinutesInOven = 40

preparationTimeInMinutes :: Num a => a -> a
preparationTimeInMinutes layers = 2 * layers

elapsedTimeInMinutes :: Num a => a -> a -> a
elapsedTimeInMinutes layers minutes = preparationTimeInMinutes layers + minutes
