module ProteinTranslation (proteins) where

chunk :: Int -> [a] -> [[a]]
chunk _ [] = []
chunk n xs = take n xs : chunk n (drop n xs)

proteins :: String -> Maybe [String]
proteins xs = translate $ chunk 3 xs

translate :: [String] -> Maybe [String]
translate [] = Just []
translate ("AUG" : rest) = ("Methionine" :) <$> translate rest
translate ("UUU" : rest) = ("Phenylalanine" :) <$> translate rest
translate ("UUC" : rest) = ("Phenylalanine" :) <$> translate rest
translate ("UUA" : rest) = ("Leucine" :) <$> translate rest
translate ("UUG" : rest) = ("Leucine" :) <$> translate rest
translate ("UCU" : rest) = ("Serine" :) <$> translate rest
translate ("UCC" : rest) = ("Serine" :) <$> translate rest
translate ("UCA" : rest) = ("Serine" :) <$> translate rest
translate ("UCG" : rest) = ("Serine" :) <$> translate rest
translate ("UAU" : rest) = ("Tyrosine" :) <$> translate rest
translate ("UAC" : rest) = ("Tyrosine" :) <$> translate rest
translate ("UGU" : rest) = ("Cysteine" :) <$> translate rest
translate ("UGC" : rest) = ("Cysteine" :) <$> translate rest
translate ("UGG" : rest) = ("Tryptophan" :) <$> translate rest
translate ("UAA" : _) = Just []
translate ("UAG" : _) = Just []
translate ("UGA" : _) = Just []
translate _ = Nothing
