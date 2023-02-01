can_chain(Pieces) :-
    permutation(Pieces, X),
    matches(X), !.

matches([]).
matches([(A,A)]).
matches([(F,B) | Rest]) :- matches([(F,B) | Rest], F).

matches([(_,F)], F).
matches([(_,B), (D,B) | Rest], F) :- matches([(B,D) | Rest], F).
matches([(_,B), (B,D) | Rest], F) :- matches([(B,D) | Rest], F).
