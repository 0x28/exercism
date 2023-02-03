hamming_distance(Str1, Str2, Dist) :-
    string_chars(Str1, List1),
    string_chars(Str2, List2),
    list_distance(List1, List2, Dist), !.


list_distance([], [], 0).
list_distance([X|XS], [X|YS], Dist) :- list_distance(XS, YS, Dist).
list_distance([_|XS], [_|YS], Dist) :- list_distance(XS, YS, D), Dist is D + 1.
