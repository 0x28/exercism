binary(Str, Dec) :- string_chars(Str, Chars), binary_list(Chars, Dec, _).

digit('0', 0).
digit('1', 1).

binary_list([], 0, 1).
binary_list([H|T], Dec, Exp) :-
    digit(H, Num),
    binary_list(T, Rest, PrevExp),
    Dec is Num * PrevExp + Rest,
    Exp is PrevExp * 2.
