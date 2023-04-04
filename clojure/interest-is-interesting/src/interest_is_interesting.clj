(ns interest-is-interesting)

(defn interest-rate
  "Calculate the interest rate based on the balance."
  [balance]
  (cond
    (>= balance 5000) 2.475
    (<= 1000 balance 5000) 1.621
    (<= 0 balance 1000) 0.5
    (< balance 0) -3.213))

(defn abs [n]
  (if (< n 0) (- n) n))

(defn annual-balance-update
  "Update balance for the current year."
  [balance]
  (let [rate (* (bigdec (interest-rate balance)) 0.01M)]
    (+ balance (* (abs balance) rate))))

(defn amount-to-donate
  "Calculate the donation amount at the end of the year."
  [balance tax-free-percentage]
  (max 0
       (int (* 2 balance tax-free-percentage 0.01M))))
