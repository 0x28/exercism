(ns bird-watcher)

(def last-week [0 2 5 3 7 8 4])

(defn today [birds]
  (peek birds))

(defn inc-bird [birds]
  (let [current (peek birds)
        others (pop birds)]
    (conj others (inc current))))

(defn day-without-birds? [birds]
  (not= nil (some zero? birds)))

(defn n-days-count [birds n]
  (reduce + (subvec birds 0 n)))

(defn busy-days [birds]
  (count (filter #(<= 5 %) birds)))

(defn odd-week? [birds]
  (or (= birds [0 1 0 1 0 1 0])
      (= birds [1 0 1 0 1 0 1])))
