nucleotide_count(DNA, Count) :-
    string_chars(DNA, L),
    count(L, [('A', 0), ('C', 0), ('G', 0), ('T', 0)], Out),
    sort(Out, Count).

count([], Prev, Prev).
count([X | Xs], Prev, Next) :-
    select((X, C), Prev, Other), !,
    U is C + 1,
    count(Xs, [(X, U) | Other], Next).
