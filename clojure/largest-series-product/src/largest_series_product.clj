(ns largest-series-product)

(defn largest-product [n digits]
  {:pre [(<= 0 n (count digits))
         (every? #(Character/isDigit %) digits)]}
  (if (= n 0) 1
      (->> digits
           (map #(Character/digit % 10))
           (partition n 1)
           (map (partial reduce *))
           (apply max))))
