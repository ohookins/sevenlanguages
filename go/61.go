package main

import (
  "io"
  "os"
  "strings"
)

type rot13Reader struct {
  r io.Reader
}

func (r *rot13Reader) Read(p []byte) (n int, err error) {
  max_length := len(p)
  n = 0
  err = nil
  temp := make([]byte, 1)

  for i, j := 0, 0; i < max_length; i++ {

    // Watch out! It is highly confusing to have both
    // the rot13Reader and the struct member for the
    // io.Reader have the same name (r) but there it
    // is. Poor example code.
    j, err = r.r.Read(temp)
    if err != nil || j != 1 {
      break
    }

    switch {
    case temp[0] >= 65 && temp[0] < 78:
      p[i] = temp[0] + 13
    case temp[0] >= 78 && temp[0] < 91:
      p[i] = temp[0] - 13
    case temp[0] >= 97 && temp[0] < 110:
      p[i] = temp[0] + 13
    case temp[0] >= 110 && temp[0] < 123:
      p[i] = temp[0] - 13
    default:
      p[i] = temp[0]
    }

    n++
  }

  return
}

func main() {
  s := strings.NewReader(
    "Lbh penpxrq gur pbqr!")
  r := rot13Reader{s}
  io.Copy(os.Stdout, &r)
}
