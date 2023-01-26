isogram(Word) :-
    string_lower(Word, LowerWord),
    string_chars(LowerWord, Chars),
    include(is_alpha, Chars, Alpha),
    is_set(Alpha).
