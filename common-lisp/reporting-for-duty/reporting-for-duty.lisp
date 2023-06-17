(defpackage :reporting-for-duty
  (:use :cl)
  (:export :format-quarter-value :format-two-quarters
           :format-two-quarters-for-reading))

(in-package :reporting-for-duty)

(defun format-quarter-value (quarter value)
  (format nil "The value ~a quarter: ~a" quarter value))

(defun format-two-quarters (stream fst-quarter fst-value snd-quarter snd-value)
  (format stream
          "~%~a~&~a~%"
          (format-quarter-value fst-quarter fst-value)
          (format-quarter-value snd-quarter snd-value)))

(defun format-two-quarters-for-reading (stream fst-quarter fst-value snd-quarter snd-value)
  (format stream
          "~s"
          (list (format-quarter-value fst-quarter fst-value)
                (format-quarter-value snd-quarter snd-value))))
