(defpackage :nth-prime
  (:use :cl)
  (:export :find-prime))

(in-package :nth-prime)

(defun first-n-primes (number)
  ;; Get the size of the sieve by using the following approximation:
  ;; https://en.wikipedia.org/wiki/Prime_number_theorem#Approximations_for_the_nth_prime_number
  (let* ((number (max number 6)) ;; approximation only works for n >= 6
         (size (ceiling (* number (+ (log number) (log (log number))))))
         (sieve (make-array size :initial-element 0)))
    (loop for idx below size
          do (setf (aref sieve idx) (+ 2 idx)))
    (loop with sieve-idx = 0 and prime = nil
          while (< sieve-idx size)
          do
             (setf prime (aref sieve sieve-idx))
             ;; remove multiples of the current prime number
             (loop for idx from (+ prime sieve-idx) below size by prime
                   do (setf (aref sieve idx) 0))
             (incf sieve-idx)
             ;; find the next prime number
             (loop while (and (< sieve-idx size)
                              (zerop (aref sieve sieve-idx)))
                   do (incf sieve-idx)))
    (remove-if #'zerop sieve)))

(defun find-prime (number)
  (when (> number 0)
    (aref (first-n-primes number) (1- number))))
