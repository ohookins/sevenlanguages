; Set up the Account protocol and record
(defprotocol AccountProtocol
  (debit [instance, amount])
  (credit [instance, amount])
  (show [instance])
)
(defrecord Account [balance]
  AccountProtocol
  (debit [_, amount] (Account. (- balance amount)))
  (credit [_, amount] (Account. (+ balance amount)))
  (show [_] (str "Balance: " balance))
)

; define the vector of ref accounts and print them
(def accounts [(ref (Account. 500)) (ref (Account. 200)) (ref (Account. -100))])
(println "Initial state of accounts:")
(println (map (fn [a] (str (show @a) ";")) accounts))
(println)

; modify the accounts and print them
(mapv (fn [a]
  (dosync
    (alter a credit 200)
  )
) accounts)
(println "After crediting each account with 200:")
(println (map (fn [a] (str (show @a) ";")) accounts))
