fun alphaPos c = Word.fromInt ((Char.ord (Char.toLower c)) - Char.ord #"a")

fun isPangram s =
    let
        val letters = List.filter Char.isAlpha (String.explode s)
        val register = fn (c, acc) => Word.orb (acc, Word.<<(0wx1, alphaPos c))
    in
        List.foldl register 0wx0 letters = 0wx3FFFFFF
    end
