package main

import "fmt"

// fibonacci is a function that returns
// a function that returns an int.
func fibonacci() func() int {
  i, j, k := 0, 0, 0
  return func() int {
    if i == 0 {
      i = 1
      return 1
    }
    if i == 1 && j == 0 {
      j = 1
      return 1
    }
    k = i
    i = i + j
    j = k
    return i
  }
}

func main() {
  f := fibonacci()
  for i := 0; i < 10; i++ {
    fmt.Println(f())
  }
}
