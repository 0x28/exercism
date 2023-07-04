#lang racket

(provide hamming-distance)

(define (hamming-distance source target)
  (if (= (string-length source)
         (string-length target))
      (for/sum ([c1 source]
                [c2 target])
        (if (char=? c1 c2) 0 1))
      (error "Different string sizes!")))
