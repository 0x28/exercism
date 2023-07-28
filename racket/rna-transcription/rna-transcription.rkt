#lang racket

(provide to-rna)

(define (to-rna dna)
  (list->string
   (for/list ([c dna])
     (match c
       [#\G #\C]
       [#\C #\G]
       [#\T #\A]
       [#\A #\U]))))
