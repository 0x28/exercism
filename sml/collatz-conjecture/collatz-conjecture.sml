fun collatz n =
    let
        fun recur i 1 = i
          | recur i m = if m mod 2 = 0 then recur (i + 1) (m div 2)
                        else recur (i + 1) (3 * m + 1)
    in
        if n > 0 then SOME (recur 0 n)
        else NONE
    end
