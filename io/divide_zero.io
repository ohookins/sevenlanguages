# Replace the built-in division operator with one that also checks for divide
# by zero errors and returns zero in those cases.

Number divideAround := Number getSlot("/")
Number / := method(divisor,
  if(divisor == 0, 0, self divideAround(divisor))
)

(99 / 3) println
(99 / 0) println
