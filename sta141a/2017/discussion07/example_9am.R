# Fibonacci
# ---------
# Write a function that generates the nth Fibonacci number.
#
# Fibonacci numbers are defined by the recurrence relation
#
# f(1) = 0
# f(2) = 1
# f(n) = f(n - 1) + f(n - 2)
#
# So the sequence is
# 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, ...

fib1 = function(n) {
  if (n == 1)
    0
  else if (n == 2)
    1
  else
    fib1(n - 1) + fib1(n - 2)
}

fib2 = function(n) {
  fib = c(0, 1, 1)
  if (n == 1)
    return(0)
  else if (n == 2)
    return(1)
  
  for (i in seq_len(n - 2)) {
    new_fib = fib[2] + fib[3]
    fib[1] = fib[2]
    fib[2] = fib[3]
    fib[3] = new_fib
  }
  
  fib[2]
}
