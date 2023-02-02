square(SquareNumber, Value) :-
    between(1, 64, SquareNumber),
    Value is 2 ^ (SquareNumber - 1).

total(Value) :-
    findall(V, square(_, V), Vs),
    sum_list(Vs, Value).
