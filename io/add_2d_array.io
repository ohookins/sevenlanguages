innerArray1 := list(1,2,3,4,5)
innerArray2 := list(2,3,4,5,6)
innerArray3 := list(3,4,5,6,7)
innerArray4 := list(4,5,6)
innerArray5 := list(7)
outerArray := list(innerArray1, innerArray2, innerArray3, innerArray4, innerArray5)

sum := 0
outerArray foreach(i, ival,
  ival foreach(j, jval, sum = sum + jval)
  )

"sum of 2d arrays is " print
sum println
exit(0)
