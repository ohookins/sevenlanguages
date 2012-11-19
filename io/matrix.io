Matrix := List clone

# Set up the basic matrix structure - a list of lists.
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

# Set a single element of a matrix.
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

# Get a single element of a matrix.
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

# Transpose x and y axes in a matrix and return the result.
Matrix transpose := method(
  # Determine dimensions and make a new matrix
  x := call target data size
  y := call target data at(0) size
  new_matrix := Matrix clone
  new_matrix dim(y, x)

  # Iterate through source matrix copying to inverse locations in destination
  for(i, 0, x - 1,
    for(j, 0, y - 1,
      new_matrix set(j, i, call target get(i, j))
    )
  )

  # Return the result
  new_matrix
)

# Serialize a matrix to a file on disk.
# Since the columns are the only things actually storing data,
# we just rely on the built-in serialized method of List.
Matrix toFile := method(filename,
  # Determine dimensions
  x := call target data size
  y := call target data at(0) size

  # Set up output file and write basic matrix layout to it
  f := File with(filename)
  f openForUpdating
  f write("mat := Matrix clone\n")
  f write("mat dim(#{x}, #{y})\n" interpolate)

  # Iterate through matrix serializing values. The naive implementation would
  # just be to write out the "mat set" method calls, but this only handles
  # types represented textually e.g. sequences, numbers, nil etc.
  for(i, 0, x - 1,
    element := call target data at(i) serialized
    f write("mat data atPut(#{i}, #{element})\n" interpolate)
  )

  # Flush and close the file
  f flush
  f close
)

# Deserialize a matrix from a file on disk.
Matrix fromFile := method(filename,
  # Open the file and basically just eval the results.
  # NOTE: For obvious reasons this is pretty unsafe.
  doFile(filename)

  return mat
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

"\nSaving matrix to a file" println
mat toFile("output.matrix")
"Loading matrix from a file" println
file_mat := Matrix fromFile("output.matrix")

"\nTransposed matrix contents (from saved file matrix): " println
new_mat := file_mat transpose
"#{new_mat get(0,0)} #{new_mat get(0,1)}" interpolate println
"#{new_mat get(1,0)} #{new_mat get(1,1)}" interpolate println

exit(0)
