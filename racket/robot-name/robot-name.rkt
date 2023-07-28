#lang racket

(provide make-robot
         name
         reset!
         reset-name-cache!)

(struct robot ([name #:mutable]))

(define (random-letter)
  (integer->char (random (char->integer #\A)
                         (+ 1 (char->integer #\Z)))))

(define existing-robots (mutable-set))

(define (random-name)
  (format "~c~c~a"
          (random-letter)
          (random-letter)
          (random 100 1000)))

(define (unique-name)
  (let ([name (random-name)])
    (if (set-member? existing-robots name)
        (unique-name)
        (begin
          (set-add! existing-robots name)
          name))))

(define (make-robot)
  (robot (unique-name)))

(define (name robot)
  (robot-name robot))

(define (reset! robot)
  (let ([old-name (robot-name robot)])
    (set-robot-name! robot (unique-name))
    (set-remove! existing-robots old-name)))

(define (reset-name-cache!)
  (set-clear! existing-robots))
