normalize(Word, Lower, Normal) :-
    string_lower(Word, Lower),
    string_chars(Lower, Chars),
    msort(Chars, Normal).

is_anagram(Word, Anagram) :-
    normalize(Word, Lower1, Normalized),
    normalize(Anagram, Lower2, Normalized),
    Lower1 \= Lower2.

anagram(Word, Options, Matching) :-
    include(is_anagram(Word), Options, Matching).
