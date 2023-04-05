(ns elyses-destructured-enchantments)

(defn first-card
  "Returns the first card from deck."
  [[first]]
  first)

(defn second-card
  "Returns the second card from deck."
  [[first second]]
  second)

(defn swap-top-two-cards
  "Returns the deck with first two items reversed."
  [[first second & rest]]
  (list* second first rest))

(defn discard-top-card
  "Returns a sequence containing the first card and
   a sequence of the remaining cards in the deck."
  [[first & rest]]
  (list first rest))

(def face-cards
  ["jack" "queen" "king"])

(defn insert-face-cards
  "Returns the deck with face cards between its head and tail."
  [[first & rest]]
  (if first
    (cons first (concat face-cards rest))
    face-cards))
