(ns accumulate)

(defn accumulate [fun [head & tail]]
  (if head
    (cons (fun head) (accumulate fun tail))
    []))
