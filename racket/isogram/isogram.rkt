#lang racket

(provide isogram?)

(define (isogram? s)
  (let ([letters-only (filter-map
                       (lambda (c)
                         (and (char-alphabetic? c)
                              (char-downcase c)))
                       (string->list s))])
    (= (set-count (list->set letters-only))
       (length letters-only))))
