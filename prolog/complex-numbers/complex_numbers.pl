real((R, _), R).
imaginary((_, I), I).

conjugate((R,I), (R, -I)).
abs((R, I), O) :- O is sqrt(R^2 + I^2).

add((A, B), (C, D), (X,Y)) :-
    X is A + C,
    Y is B + D.

sub(N, (C, D), O) :- add(N, (-C, -D), O).

mul((A, B), (C, D), (X,Y)) :-
    X is A * C - B * D,
    Y is B * C + A * D.

div((A, B), (C, D), (X,Y)) :-
    X is (A * C + B * D) / (C^2 + D^2),
    Y is (B * C - A * D) / (C^2 + D^2).
