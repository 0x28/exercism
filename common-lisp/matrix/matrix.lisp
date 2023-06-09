(defpackage :matrix
  (:use :cl)
  (:export :row :column))

(in-package :matrix)

(defun split (string delimiter)
  (loop
    with pos = 0
    while (< pos (length string))
    collecting
    (let ((new-pos (position delimiter string :start pos)))
      (if new-pos
          (prog1 (subseq string pos new-pos) ; found delimiter
            (setf pos (1+ new-pos)))
          (prog1 (subseq string pos) ; didn't find delimiter -> stop
            (setf pos (length string)))))))

(defun parse-matrix (input)
  (mapcar (lambda (row) (mapcar #'parse-integer (split row #\space)))
          (split input #\newline)))

(defun row (input-matrix index)
  (nth (1- index) (parse-matrix input-matrix)))

(defun column (input-matrix index)
  (mapcar (lambda (row) (nth (1- index) row))
          (parse-matrix input-matrix)))
