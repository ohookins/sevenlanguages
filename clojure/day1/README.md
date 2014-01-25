## Running these examples

(Assuming you have Leiningen installed already...)

### (big st n)
```
lein repl
user=> (load-file "big_st_n.clj")
user=> (big "foo bar baz" 10)
true
```

### (collection-type col)
```
lein repl
user=> (load-file "collection_type_col.clj")
user=> (collection-type [1 2 3])
:vector
```
