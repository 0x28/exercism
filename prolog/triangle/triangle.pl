triangular(Side1, Side2, Side3) :-
    Side1 > 0, Side2 > 0, Side3 > 0,
    Side1 + Side2 >= Side3, Side1 + Side3 >= Side2, Side3 + Side2 >= Side1.

triangle(Side1, Side2, Side3, "equilateral") :-
    Side1 = Side2, Side2 = Side3, triangular(Side1, Side2, Side3), !.

triangle(Side1, Side2, Side3, "isosceles") :-
    (Side1 = Side2; Side2 = Side3; Side1 = Side3),
    triangular(Side1, Side2, Side3), !.

triangle(Side1, Side2, Side3, "scalene") :-
    not(Side1 = Side2), not(Side2 = Side3), not(Side3 = Side1),
    triangular(Side1, Side2, Side3).
