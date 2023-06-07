(defpackage :lillys-lasagna
  (:use :cl)
  (:export :expected-time-in-oven
           :remaining-minutes-in-oven
           :preparation-time-in-minutes
           :elapsed-time-in-minutes))

(in-package :lillys-lasagna)

(defun expected-time-in-oven ()
  "Returns how many minutes the lasagna should be in the oven."
  337)

(defun remaining-minutes-in-oven (elapsed)
  "Returns how many minutes the lasagna still has to remain in the oven, based on
the expected oven time in minutes and the elapsed time."
  (- (expected-time-in-oven) elapsed))

(defun preparation-time-in-minutes (layers)
  "Returns how many minutes are spent preparing the lasagna, based on the given
layers."
  (* layers 19))

(defun elapsed-time-in-minutes (layers elapsed)
  "Returns how many minutes the lasagna has been worked on."
  (+ elapsed (preparation-time-in-minutes layers)))
