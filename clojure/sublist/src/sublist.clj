(ns sublist)

(defn sublist? [lst sub]
  (some #(= % sub)
        (partition (count sub) 1 lst)))

(defn classify [list1 list2]
  (cond
    (= list1 list2) :equal
    (sublist? list1 list2) :superlist
    (sublist? list2 list1) :sublist
    :else :unequal))
