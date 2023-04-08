(ns difference-of-squares)

(defn difference [n]
  (* 1/12 n (+ n 1) (+ (* 3 n) 2) (- n 1)))

(defn sum-of-squares [n]
  (* 1/6 n (+ n 1) (+ (* 2 n) 1)))

(defn square [n]
  (* n n))

(defn square-of-sum [n]
  (square (* n (+ n 1) 1/2)))
