string_reverse(Str, Reversed) :-
    string_reverse(Str, 1, [], RStr),
    string_codes(Reversed, RStr), !.

string_reverse(Str, Idx, Acc, Result) :-
    (string_code(Idx, Str, Char),
     NIdx is Idx + 1,
     string_reverse(Str, NIdx, [Char | Acc], Result));
    Result = Acc.
