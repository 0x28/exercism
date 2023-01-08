fun isBracket c =
    List.exists (fn br => c = br) (String.explode "[](){}")

fun isBalanced s =
    let
        fun iter (#"["::stack) (#"]"::rest) = iter stack rest
          | iter (#"("::stack) (#")"::rest) = iter stack rest
          | iter (#"{"::stack) (#"}"::rest) = iter stack rest
          | iter stack (#"["::rest) = iter (#"["::stack) rest
          | iter stack (#"("::rest) = iter (#"("::stack) rest
          | iter stack (#"{"::rest) = iter (#"{"::stack) rest
          | iter [] [] = true
          | iter stack (char::rest) = if isBracket char then false
                                      else iter stack rest
          | iter stack rest = false
    in
        iter [] (String.explode s)
    end
