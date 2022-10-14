module ValentinesDay where

data Approval = Yes | No | Maybe

data Cuisine = Korean | Turkish

data Genre = Crime | Horror | Romance | Thriller

data Activity = BoardGame | Chill | Movie !Genre | Restaurant !Cuisine | Walk !Int

rateActivity :: Activity -> Approval
rateActivity BoardGame = No
rateActivity Chill = No
rateActivity (Movie Romance) = Yes
rateActivity (Movie _) = No
rateActivity (Restaurant Korean) = Yes
rateActivity (Restaurant Turkish) = Maybe
rateActivity (Walk km)
  | km < 3 = Yes
  | km <= 5 = Maybe
  | otherwise = No
