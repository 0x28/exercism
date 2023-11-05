(defpackage :matching-brackets
  (:use :cl)
  (:export :pairedp))

(in-package :matching-brackets)

(defun pairedp (value)
  (let (stack)
    (dolist (char (coerce value 'list))
      (case char
        (#\( (push #\) stack))
        (#\[ (push #\] stack))
        (#\{ (push #\} stack))
        ((#\) #\] #\})
         (when (or (not stack)
                   (char/= char (car stack)))
           (return-from pairedp nil))
         (pop stack))))
    (not stack)))
