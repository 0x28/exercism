(defpackage :high-scores
  (:use :cl)
  (:export :make-high-scores-table :add-player
           :set-score :get-score :remove-player))

(in-package :high-scores)

(defun make-high-scores-table ()
  (make-hash-table))

(defun add-player (high-scores player)
  (set-score high-scores player 0))

(defun set-score (high-scores player score)
  (setf (gethash player high-scores) score))

(defun get-score (high-scores player)
  (gethash player high-scores 0))

(defun remove-player (high-scores player)
  (remhash player high-scores))
