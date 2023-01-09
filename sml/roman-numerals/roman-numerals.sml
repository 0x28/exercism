fun roman (number: int): string =
    let
        fun roman' n =
            if n >= 1000 then #"M" :: roman' (n - 1000)
            else if n >= 900 then #"C" :: #"M" :: roman' (n - 900)
            else if n >= 500 then #"D" :: roman' (n - 500)
            else if n >= 400 then #"C" :: #"D" :: roman' (n - 400)
            else if n >= 100 then #"C" :: roman' (n - 100)
            else if n >= 90 then #"X" :: #"C" :: roman' (n - 90)
            else if n >= 50 then #"L" :: roman' (n - 50)
            else if n >= 40 then #"X" :: #"L" :: roman' (n - 40)
            else if n >= 10 then #"X" :: roman' (n - 10)
            else if n = 9 then [#"I", #"X"]
            else if n >= 5 then #"V" :: roman' (n - 5)
            else if n = 4 then [#"I", #"V"]
            else if n = 0 then []
            else #"I" :: roman' (n - 1)
    in
        (String.implode o roman') number
    end
