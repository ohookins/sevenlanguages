## Running these examples

### unless_else.clj
```
lein repl
user=> (load-file "unless_else.clj")
user=> (unless true (println "It was false") (println "It was true"))
It was true
nil
user=> (unless false (println "It was false"))
It was false
nil
```

### my_type.clj
```
lein repl
user=> (load-file "my_type.clj")
user=> (def m (MyType. 5))
user=> (mult m 10)
50
user=> (div m 10)
1/2
```
