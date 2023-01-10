fun reverse (list) =
    let
        fun reverse' acc [] = acc
          | reverse' acc (x::xs) = reverse' (x::acc) xs
    in
        reverse' [] list
    end

fun filter (_, []) = []
  | filter (function, x::xs) =
    if function x then x :: filter (function, xs)
    else filter (function, xs)

fun map (_, []) = []
  | map (function, x::xs) = function x :: map (function, xs)

fun append ([], list2) = list2
  | append (x::xs, list2) = x :: append (xs, list2)

fun length ([]) = 0
  | length (x::xs) = 1 + length xs

fun foldl (_, initial, []) = initial
  | foldl (function, initial, x::xs) = foldl (function, function (initial, x), xs)

fun foldr (_, initial, []) = initial
  | foldr (function, initial, x::xs) = function (x, foldr (function, initial, xs))

fun concat ([]) = []
  | concat (x::xs) = append (x, concat xs)
