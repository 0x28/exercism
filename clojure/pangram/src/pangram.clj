(ns pangram
  (:require [clojure.string :as str]))

(defn pangram? [sentence]
  (loop [letters (hash-set)
         chars (->> (seq sentence)
                    (filter #(Character/isLetter %))
                    (map str/lower-case))]
    (if (empty? chars)
      (= (count letters) 26)
      (recur (conj letters (first chars))
             (rest chars)))))
