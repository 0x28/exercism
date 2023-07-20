#lang racket

(provide encode decode)

(define (encode . nums)
  (flatten
   (map (curry encode-number '())
        nums)))

(define (encode-number encoded num)
  (let* ((seven-bit (bitwise-and num #x7f))
         (byte (if (null? encoded) seven-bit (bitwise-ior #x80 seven-bit)))
         (rest (arithmetic-shift num -7)))
    (if (and (zero? num)
             (not (null? encoded)))
        encoded
        (encode-number (cons byte encoded)
                       rest))))

(define (decode . nums)
  (match (decode-number 0 nums)
    [(cons remaining num)
     (if (null? remaining)
         (list num)
         (cons num (apply decode remaining)))]))

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
