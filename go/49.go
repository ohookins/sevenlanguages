package main

import (
  "fmt"
  "math/cmplx"
  "math"
)

func Cbrt(x complex128) complex128 {
  z := complex128(1)
  for {
    y := z
    z = z - (cmplx.Pow(z, 3) - x)/(3 * cmplx.Pow(z, 2))
    if cmplx.Abs(y - z) < 0.01 {
      break
    }
  }
  return z
}

func main() {
  fmt.Println(Cbrt(2))
  fmt.Println(math.Cbrt(2))
}
