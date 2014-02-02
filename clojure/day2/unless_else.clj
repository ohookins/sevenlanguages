(defmacro unless
  ([test then]
    `(unless ~test ~then nil)
  )
  ([test then else]
    `(if (not ~test) ~then ~else)
  )
)
