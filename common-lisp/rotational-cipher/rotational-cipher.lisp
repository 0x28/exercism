(defpackage :rotational-cipher
  (:use :cl)
  (:export :rotate))

(in-package :rotational-cipher)

(defun character-rotate (char key)
  (flet ((shift (start)
           (code-char (+ (mod (+ (- (char-code char) start)
                                 key)
                              26)
                         start))))
    (cond ((lower-case-p char) (shift (char-code #\a)))
          ((upper-case-p char) (shift (char-code #\A)))
          (t char))))

(defun rotate (text key)
  (map 'string (lambda (c) (character-rotate c key)) text))
