tree_traversals(Tree, Preorder, Inorder) :-
    phrase(walk_preorder(Tree), Preorder),
    phrase(walk_inorder(Tree), Inorder).

walk_inorder(nil) --> [].
walk_inorder(node(Left, Value, Right)) -->
    walk_inorder(Left),
    [Value],
    walk_inorder(Right).

walk_preorder(nil) --> [].
walk_preorder(node(Left, Value, Right)) -->
    [Value],
    walk_preorder(Left),
    walk_preorder(Right).
