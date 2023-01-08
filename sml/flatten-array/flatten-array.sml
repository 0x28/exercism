(* Rose tree *)
datatype 'a tree = Empty | Elem of 'a | List of 'a tree list

fun flatten tree =
    let
        fun flatten' (Empty, res) = res
          | flatten' (Elem v, res) = v :: res
          | flatten' (List trees, res) = List.foldr flatten' res trees
    in
        flatten' (tree, [])
    end
