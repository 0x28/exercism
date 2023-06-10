(defpackage :binary-search
  (:use :cl)
  (:export :binary-find :value-error))

(in-package :binary-search)

(defun binary-find (arr el)
  (loop with lower = 0 and upper = (1- (length arr))
        while (<= lower upper)
        do (let* ((idx (floor (/ (+ lower upper) 2)))
                  (element (aref arr idx)))
             (cond ((= element el) (return idx))
                   ((< element el) (setf lower (1+ idx)))
                   ((> element el) (setf upper (1- idx)))))))
