%! create(+DimTuple)
%
% The create/1 predicate succeeds if the DimTuple contains valid chessboard
% dimensions, e.g. (0,0) or (2,4).
create((DimX, DimY)) :- DimX >= 0, 8 > DimX, DimY >= 0, 8 > DimY.

%! attack(+FromTuple, +ToTuple)
%
% The attack/2 predicate succeeds if a queen positioned on ToTuple is
% vulnerable to an attack by another queen positioned on FromTuple.
attack((FromX, FromY), (ToX, ToY)):-
    FromX = ToX, !;
    FromY = ToY, !;
    abs(FromX - ToX, DistX), abs(FromY - ToY, DistY), DistX = DistY.
