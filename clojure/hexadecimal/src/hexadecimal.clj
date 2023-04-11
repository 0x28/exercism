(ns hexadecimal)

(def digit-to-int (zipmap "0123456789abcdef" (range)))

(defn hex-to-int [hex-str]
  (or (reduce #(if (and %1 %2) (+ (* 16 %1) %2))
              (map digit-to-int hex-str))
      0))
