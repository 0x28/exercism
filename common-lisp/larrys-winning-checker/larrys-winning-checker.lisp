(defpackage :larrys-winning-checker
  (:use :cl)
  (:export
   :make-empty-board
   :make-board-from-list
   :all-the-same-p
   :row
   :column))

(in-package :larrys-winning-checker)

(defconstant +board-size+ 3)

(defun make-empty-board ()
  (make-array (list +board-size+ +board-size+) :initial-element nil))

(defun make-board-from-list (list)
  (make-array (list +board-size+ +board-size+) :initial-contents list))

(defun all-the-same-p (row-or-col)
  (let ((first (aref row-or-col 0)))
    (every (lambda (e) (eq e first)) row-or-col)))

(defun row (board row-num)
  (let ((row (make-array +board-size+)))
    (loop for idx from 0 below (length row)
          do (setf (aref row idx) (aref board row-num idx)))
    row))

(defun column (board col-num)
  (let ((col (make-array +board-size+)))
    (loop for idx from 0 below (length col)
          do (setf (aref col idx) (aref board idx col-num)))
    col))
