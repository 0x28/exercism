(defpackage :lillys-lasagna-leftovers
  (:use :cl)
  (:export
   :preparation-time
   :remaining-minutes-in-oven
   :split-leftovers))

(in-package :lillys-lasagna-leftovers)

(defun preparation-time (&rest layers)
  (* 19 (length layers)))

(defun remaining-minutes-in-oven (&optional (time :normal))
  (let ((default-time 337))
    (case time
      (:normal default-time)
      (:shorter (- default-time 100))
      (:very-short (- default-time 200))
      (:longer (+ default-time 100))
      (:very-long (+ default-time 200))
      (t 0))))

(defun split-leftovers (&key (weight nil weight-p) (alien 10) (human 10))
  (cond ((and weight-p (null weight)) :looks-like-someone-was-hungry)
        ((null weight) :just-split-it)
        (t (max 0 (- weight alien human)))))
