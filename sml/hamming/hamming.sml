fun hamming ([], []) = SOME 0
  | hamming ((x :: xs), (y :: ys)) =
    Option.map (fn diff => if x = y then diff else diff + 1) (hamming(xs, ys))
  | hamming (_, _) = NONE

fun distance (strand1: string, strand2: string): int option =
    hamming (String.explode strand1, String.explode strand2)
