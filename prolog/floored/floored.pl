floor(Name, Floor) :-
    floors(Fs),
    nth1(Floor, Fs, Name), !.

adjacent(A, B) :-
    succ(A, B), !; succ(B, A).

floors(Fs) :-
    length(Fs, 5),
    nth1(AmaraFloor, Fs, amara),
    not(AmaraFloor is 5),
    nth1(BjornFloor, Fs, bjorn),
    not(BjornFloor is 1),
    nth1(CoraFloor, Fs, cora),
    not(CoraFloor is 1), not(CoraFloor is 5),
    nth1(DaleFloor, Fs, dale),
    DaleFloor > BjornFloor,
    nth1(EmikoFloor, Fs, emiko),
    not(adjacent(EmikoFloor, CoraFloor)),
    not(adjacent(CoraFloor, BjornFloor)).
