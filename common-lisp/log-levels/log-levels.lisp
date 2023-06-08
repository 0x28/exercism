(defpackage :log-levels
  (:use :cl)
  (:export :log-message :log-severity :log-format))

(in-package :log-levels)

(defun log-message (log-string)
  (let ((start-idx (position #\: log-string)))
    (string-trim " " (subseq log-string (1+ start-idx)))))

(defun log-severity (log-string)
  (flet ((level-p (level) (search level log-string :test #'string-equal)))
    (cond ((level-p "[info]") :everything-ok)
          ((level-p "[warn]") :getting-worried)
          ((level-p "[ohno]") :run-for-cover))))

(defun log-format (log-string)
  (funcall
   (case (log-severity log-string)
     (:everything-ok #'string-downcase)
     (:getting-worried #'string-capitalize)
     (:run-for-cover #'string-upcase))
   (log-message log-string)))
