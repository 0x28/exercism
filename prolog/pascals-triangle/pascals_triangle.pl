pascal(I, Tri) :- pascal(I, [], Tri).

pascal(0, _, []) :- !.
pascal(I, Prev, [Curr | Rest]) :-
    J is I - 1,
    layer(Prev, L), Curr = [1 | L],
    pascal(J, Curr, Rest), !.

layer([F, S | Rest], [C | L]) :-
    C is F + S,
    layer([S | Rest], L).
layer(L, L).
