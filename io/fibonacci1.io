// Find the xth Fibonacci number recursively

fib := method(x, if(x <= 2, return 1, return fib(x - 1) + fib(x - 2)))

fib(5) print; " is the 5th Fibonacci number" println
fib(10) print; " is the 10th Fibonacci number" println
fib(15) print; " is the 15th Fibonacci number" println
fib(20) print; " is the 20th Fibonacci number" println

exit(0)
