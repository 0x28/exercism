(defpackage :lucys-magnificent-mapper
  (:use :cl)
  (:export :make-magnificent-maybe :only-the-best))

(in-package :lucys-magnificent-mapper)

(defun make-magnificent-maybe (fun list)
  (mapcar fun list))

(defun only-the-best (pred list)
  ;; Only traverse the list once.
  (remove-if (lambda (n) (or (= n 1) (funcall pred n)))
             list))
