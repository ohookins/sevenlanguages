package main

import (
	"fmt"
	"math"
)

type ErrNegativeSqrt float64

func (e ErrNegativeSqrt) Error() string {
	return fmt.Sprintf("cannot Sqrt negative number: %f", float64(e))
}

func Sqrt(f float64) (float64, error) {
	if f < 0 {
		e := ErrNegativeSqrt(f)
		return 0, e
	}

	z := 1.0
	for {
		y := z
		z = z - (z*z-f)/(2*z)
		if math.Abs(y-z) < 0.1 {
			break
		}
	}
	return z, nil
}

func main() {
	fmt.Println(Sqrt(2))
	v, err := Sqrt(-2)
	if err != nil {
		fmt.Println(err)
	} else {
		fmt.Println(v)
	}
}
