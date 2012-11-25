package main

import (
  "fmt"
  "math"
)

func Sqrt(x float64) (float64, int) {
  z := 1.0
  iterations := 0
  for {
    iterations++
    y := z
    z = z - (z*z - x)/(2 * z)
    fmt.Println(z)
    if math.Abs(y - z) < 0.1 {
      break
    }
  }
  return z, iterations
}

func main() {
  val := 1512.0
  fmt.Printf("Calculating square root of %f\n", val)
  x, i := Sqrt(val)
  fmt.Printf("%f calculated in %d iterations\n", x, i)
  fmt.Println(math.Sqrt(val))
}
