## Running these examples

### accounts_vector.clj
```
lein repl
user=> (load-file "accounts_vector.clj")
```
Output of the program is printed.

### sleeping_barber.clj
```
lein repl
user=> (load-file "sleeping_barber.clj")
The barber gave a total of 468 haircuts in 10.0 seconds.
A total of 477 customers attempted to get their hair cut.
nil
```

This is probably not a fantastic implementation. It solves the concurrency/locking
issue but doesn't implement the algorithm as literally stated (e.g. walking between
rooms, sitting down, waking up the barber etc).
