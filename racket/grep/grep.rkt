#lang racket

(provide grep)

(define (grep flags pattern files)
  (let ([line-numbers (member "-n" flags)]
        [file-name-only (member "-l" flags)]
        [case-insensitive (member "-i" flags)]
        [invert (member "-v" flags)]
        [entire-line (member "-x" flags)]
        [file-name (> (length files) 1)])
    (flatten
     (for/list ([file files])
       (with-input-from-file file
         (lambda ()
           (let ([next-file #f])
             (for/list ([line (in-lines)]
                        [line-number (in-naturals 1)])
               #:break next-file
               (let* ([transform (if case-insensitive string-downcase identity)]
                      [matches (if entire-line
                                   (string=? (transform line) (transform pattern))
                                   (string-contains? (transform line) (transform pattern)))]
                      [matches (if invert (not matches) matches)])
                 (if matches
                     (cond [file-name-only
                            (set! next-file #t)
                            file]
                           [else
                            (string-append
                             (if file-name (format "~a:" file) "")
                             (if line-numbers (format "~a:" line-number) "")
                             line)])
                     (list)))))))))))
