#lang typed/racket

(provide encode decode)

(: encode (-> Integer * (Listof Integer)))
(define (encode . nums)
  (append*
   (map (curry encode-number '())
        nums)))

(: encode-number (-> (Listof Integer) Integer (Listof Integer)))
(define (encode-number encoded num)
  (let* ((seven-bit (bitwise-and num #x7f))
         (byte (if (null? encoded) seven-bit (bitwise-ior #x80 seven-bit)))
         (rest (arithmetic-shift num -7)))
    (if (and (zero? num)
             (not (null? encoded)))
        encoded
        (encode-number (cons byte encoded)
                       rest))))

(: decode (-> Integer * (Listof Integer) ))
(define (decode . nums)
  (match (decode-number 0 nums)
    [(cons remaining num)
     (if (null? remaining)
         (list num)
         (cons num (apply decode remaining)))]))

(: decode-number (-> Integer
                     (Listof Integer)
                     (Pairof (Listof Integer) Integer)))
(define (decode-number num encoded)
  (if (null? encoded)
      (cons '() num)
      (let* ((byte (first encoded))
             (seven-bit (bitwise-and #x7f byte))
             (more (> (bitwise-and #x80 byte) 0))
             (num (bitwise-ior (arithmetic-shift num 7) seven-bit))
             (remaining (rest encoded)))
        (cond [(and more (null? remaining))
               (error "Incomplete VLQ sequence")]
              [more
               (decode-number num remaining)]
              [else
               (cons remaining num)]))))
