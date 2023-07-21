#lang typed/racket

(provide encode decode)

(define m 26)

(: coprime? (-> Positive-Fixnum Positive-Fixnum Boolean))
(define (coprime? a m)
  (= (gcd a m) 1))

(: make-groups (->* ((Listof Char)) (Integer) (Listof Char)))
(define (make-groups lst [i 1])
  (if (null? lst)
      lst
      (let ([elem (first lst)]
            [remaining (rest lst)])
        (if (and (= (modulo i 5) 0) (not (null? remaining)))
            (cons elem (cons #\space (make-groups remaining (+ i 1))))
            (cons elem (make-groups remaining (+ i 1)))))))

(: encode-letter (-> Char Positive-Fixnum Positive-Fixnum Char))
(define (encode-letter letter a b)
  (if (char-alphabetic? letter)
      (let* ([start-value (char->integer #\a)]
             [index (- (char->integer (char-downcase letter))
                       start-value)])
        (integer->char (+ start-value (modulo (+ (* a index) b) m))))
      letter))

(: encode (-> String Positive-Fixnum Positive-Fixnum String))
(define (encode msg a b)
  (unless (coprime? a m)
    (error "~a isn't coprime to ~m" a))
  (list->string
   (make-groups
    (filter-map
     (lambda ([c : Char])
       (and (or (char-alphabetic? c) (char-numeric? c))
            (encode-letter c a b)))
     (string->list msg)))))

(: mmi (-> Positive-Fixnum Positive-Fixnum Integer))
(define (mmi a m)
  (: extended-gcd (-> Integer Integer Integer Integer Integer Integer Integer))
  (define (extended-gcd old-r r old-s s old-t t)
    (if (zero? r)
        old-s
        (let ([q (quotient old-r r)])
          (extended-gcd r (- old-r (* q r))
                        s (- old-s (* q s))
                        t (- old-t (* q t))))))
  (extended-gcd a m 1 0 0 1))

(: decode-letter (-> Char Positive-Fixnum Integer Char))
(define (decode-letter letter b inverse)
  (if (char-alphabetic? letter)
      (let* ([start-value (char->integer #\a)]
             [index (- (char->integer letter) start-value)])
        (integer->char (+ start-value (modulo (* inverse (- index b)) m))))
      letter))

(: decode (-> String Positive-Fixnum Positive-Fixnum String))
(define (decode msg a b)
  (unless (coprime? a m)
    (error "~a isn't coprime to ~m" a))
  (let ([inverse (mmi a m)])
    (list->string (filter-map
                   (lambda ([c : Char])
                     (and (or (char-alphabetic? c) (char-numeric? c))
                          (decode-letter c b inverse)))
                   (string->list msg)))))
