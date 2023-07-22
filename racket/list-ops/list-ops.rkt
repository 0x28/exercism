#lang racket

(provide my-length
         my-reverse
         my-map
         my-filter
         my-fold
         my-append
         my-concatenate)

(define (my-length sequence)
  (my-fold (lambda (_ sum) (+ sum 1))
           0
           sequence))

(define (my-reverse sequence)
  (my-fold cons '() sequence))

(define (my-map operation sequence)
  (if (null? sequence)
      '()
      (cons (operation (first sequence))
            (my-map operation (rest sequence)))))

(define (my-filter operation? sequence)
  (if (null? sequence)
      '()
      (let ([head (first sequence)])
        (if (operation? head)
            (cons head (my-filter operation? (rest sequence)))
            (my-filter operation? (rest sequence))))))

(define (my-fold operation accumulator sequence)
  (if (null? sequence)
      accumulator
      (my-fold operation
               (operation (first sequence) accumulator)
               (rest sequence))))

(define (my-append sequence1 sequence2)
  (if (null? sequence1)
      sequence2
      (cons (first sequence1)
            (my-append (rest sequence1) sequence2))))

(define (my-concatenate sequence-of-sequences)
  (my-fold my-append '() (my-reverse sequence-of-sequences)))
