// Find the xth Fibonacci number in a loop
// TODO: Use less variables - it feels like there are more than necessary.

fib := method(x,  next := 1; last_one := 1; last_two := 1; i := 1
                  while(i <= x,
                    if(i <= 2,
                    true,
                    next = last_one + last_two
                      last_one = last_two
                      last_two = next)
                    i = i + 1
                  )
                  return next
              )

fib(5) print; " is the 5th Fibonacci number" println
fib(10) print; " is the 10th Fibonacci number" println
fib(15) print; " is the 15th Fibonacci number" println
fib(20) print; " is the 20th Fibonacci number" println

exit(0)
