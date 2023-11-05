(defpackage :leap
  (:use :cl)
  (:export :leap-year-p))
(in-package :leap)

(defun leap-year-p (year)
  (flet ((divisible-p (n d) (zerop (mod n d))))
    (or (divisible-p year 400)
        (and (divisible-p year 4)
             (not (divisible-p year 100))))))
