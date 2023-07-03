#lang racket

(provide collatz)

(define (collatz num)
  (cond [(not (positive-integer? num)) (error "Expected positive integer!")]
        [(= num 1) 0]
        [(even? num) (+ 1 (collatz (/ num 2)))]
        [else (+ 1 (collatz (+ (* num 3) 1)))]))
