(defn collection-type
  "Returns a keyword representing the collection type of col"
  [col]
  (
    let [m {clojure.lang.PersistentHashSet :map,
            clojure.lang.PersistentVector :vector,
            clojure.lang.PersistentList :list}]
    (get m (class col))
  )
)
