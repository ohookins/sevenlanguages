List average := method(
  count := 0
  sum   := 0
  self foreach(i, val,
    if (val type == "Number", count = count + 1; sum = sum + val)
  )
  sum / count
)

"Average of " print
list1 := list(13, 23, 37, "hello", 53, 76)
list1 print
" is " print
list1 average println

"Average of " print
list2 := list("foo", "bar", "baz")
list2 print
" is " print
list2 average println

exit(0)
