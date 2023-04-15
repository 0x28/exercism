(ns bank-account)

(defn open-account []
  (atom 0))

(defn close-account [account]
  (reset! account nil))

(defn get-balance [account]
  @account)

(defn update-balance [account value]
  (assert @account "Account closed!")
  (swap! account #(+ % value)))
