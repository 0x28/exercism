(defpackage :logans-numeric-partition
  (:use :cl)
  (:export :categorize-number :partition-numbers))

(in-package :logans-numeric-partition)

(defun categorize-number (lists number)
  (destructuring-bind (odd-list . even-list) lists
    (if (oddp number)
        (cons (cons number odd-list) even-list)
        (cons odd-list (cons number even-list)))))

(defun partition-numbers (list)
  (reduce #'categorize-number list :initial-value '(nil . nil)))
