(defprotocol MyProto
  (mult [instance, x])
  (div [instance, x])
)

(defrecord MyType [y]
  MyProto
  (mult [_, x] (* y x))
  (div [_, x] (/ y x))
)
