(ns perfect-numbers)

(defn factor [n]
  (loop [i (dec n)
         factors []]
    (cond
      (zero? i) factors
      (zero? (mod n i)) (recur (dec i) (cons i factors))
      :else (recur (dec i) factors))))

(defn classify [n]
  (if (neg? n)
    (throw (IllegalArgumentException. "Expected a positive integer!"))
    (let [aliquot-sum (reduce + (factor n))]
      (cond
        (= aliquot-sum n) :perfect
        (> aliquot-sum n) :abundant
        :else :deficient))))
