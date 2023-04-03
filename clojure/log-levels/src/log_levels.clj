(ns log-levels
  (:require [clojure.string :as str]))

(defn parse
  "Parse the log line into a list of tokens."
  [line]
  (->> (re-matches #"(?s)\[([A-Z]+)\]:\w*(.*)" line)
       (map str/trim)
       rest))

(defn message
  "Takes a string representing a log line
   and returns its message with whitespace trimmed."
  [s]
  (last (parse s)))

(defn log-level
  "Takes a string representing a log line
   and returns its level in lower-case."
  [s]
  (str/lower-case (first (parse s))))

(defn reformat
  "Takes a string representing a log line and formats it
   with the message first and the log level in parentheses."
  [s]
  (format "%s (%s)" (message s) (log-level s)))
