(defpackage :gigasecond-anniversary
  (:use :cl)
  (:export :from))
(in-package :gigasecond-anniversary)

(defun from (year month day hour minute second)
  (let ((uni-time (encode-universal-time second minute hour day month year 0)))
    (multiple-value-bind (second minute hour day month year)
        (decode-universal-time (+ uni-time 1000000000) 0)
      (list year month day hour minute second))))
