package main

import (
  "tour/wc"
  "strings"
)

func WordCount(s string) (counts map[string]int) {
  splitstring := strings.Fields(s)
 
  counts = make(map[string]int)

  for _, word := range splitstring {
    counts[word]++
  }
  return
}

func main() {
  wc.Test(WordCount)
}
