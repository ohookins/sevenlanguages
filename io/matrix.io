Matrix := List clone

Matrix dim := method(
  x := call evalArgAt(0)
  y := call evalArgAt(1)

  # Check that x and y are both numbers.
  if(x type != "Number" or y type != "Number",
    Exception raise("Arguments must be numbers")
  )

  # Set up number of elements in the matrix
  column := list() setSize(y)
  row    := list() setSize(x)

  # Set a clone of the column in each entry of the row, making the matrix.
  row foreach(i, v,
    row atPut(i, column clone)
  )

  # Actually save it to a slot in the instance... I guess.
  call target data := row
  call target data
)

Matrix set := method(x, y, value,
  # Safety check
  if (x > call target data size - 1,
    Exception raise("#{x} exceeds width of matrix" interpolate)
  )
  if (y > call target data at(x) size - 1,
    Exception raise("#{y} exceeds height of matrix" interpolate)
  )

  call target data at(x) atPut(y, value)
)

Matrix get := method(x, y,
  # Safety check
  if (x > call target data size - 1,
    Exception raise("#{x} exceeds width of matrix" interpolate)
  )
  if (y > call target data at(x) size - 1,
    Exception raise("#{y} exceeds height of matrix" interpolate)
  )

  call target data at(x) at(y)
)

mat := Matrix clone
mat dim(2, 2)

mat set(0,0,"foo")
mat set(0,1,"bar")
mat set(1,0,5)
mat set(1,1,10)

"Matrix contents: " println
"#{mat get(0,0)} #{mat get(0,1)}" interpolate println
"#{mat get(1,0)} #{mat get(1,1)}" interpolate println

exit(0)
