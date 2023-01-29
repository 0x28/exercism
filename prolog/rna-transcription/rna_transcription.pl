rna_transcription(Dna, Rna) :-
    string_chars(Dna, DnaChars),
    maplist(dna_to_rna, DnaChars, Res),
    string_chars(Rna, Res).

dna_to_rna('G', 'C').
dna_to_rna('C', 'G').
dna_to_rna('T', 'A').
dna_to_rna('A', 'U').
