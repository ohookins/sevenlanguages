package main

import (
  "image"
  "image/color"
  "tour/pic"
)

type Image struct {
  X, Y int
}

func (i *Image) ColorModel() color.Model {
  return color.RGBAModel
}

func (i *Image) Bounds() image.Rectangle {
  return image.Rect(0, 0, i.X, i.Y)
}

func (i *Image) At(x, y int) color.Color {
  return color.RGBA{uint8(x ^ y), 0, 255, 255}
}

func main() {
  m := Image{500, 500}
  pic.ShowImage(&m)
}
