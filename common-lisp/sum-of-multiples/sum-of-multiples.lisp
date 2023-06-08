(defpackage :sum-of-multiples
  (:use :cl)
  (:export :sum))

(in-package :sum-of-multiples)

(defun sum (factors limit)
  (let ((multiples nil))
    (loop for factor in factors
          unless (zerop factor) do
            (loop for num from factor below limit by factor
                  do (setf multiples (cons num multiples))))
    (reduce #'+ (remove-duplicates multiples))))
