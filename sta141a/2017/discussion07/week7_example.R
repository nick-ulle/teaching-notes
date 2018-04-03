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


# The naive, recursive solution to Fibonacci is incredibly
# inefficient:
fib1 = function(n) {
  if (n == 1)
    0
  else if (n == 2)
    1
  else
    fib1(n - 2) + fib1(n - 1)
}


# Slightly better version:
fib2 = function(n) {
  ans = c(NA, 0, 1)
  for (i in 1:n) {
    x = ans[2:3]
    ans = c(x, sum(x))
  }

  ans[[1]]
}


# Best version:
fib3 = function(n) {
  phi = (1 + sqrt(5)) / 2
  psi = (1 - sqrt(5)) / 2

  n = n - 1
  (phi^n - psi^n) / sqrt(5)
}

# Switching to a for-loop is not what makes the second
# version faster. Recursion and for-loops have similar
# performance in R.
#
# The second version is faster because it does not do any
# redundant computations. Think about how the first version
# computes the 5th number:
#
#                       fib(2)
#                      /
#                fib(3)
#               /      \
#         fib(4)        fib(1)
#        /      \
#       /        fib(2)
# fib(5)
#       \        fib(2)
#        \      /
#         fib(3)
#               \
#                fib(1)
#
# Notice that fib(3) is computed 2 times, fib(2) is
# computed 3 times, and so on.


# The microbenchmark package is useful for timing things.
library(microbenchmark)

microbenchmark(
  fib1 = fib1(10), fib2 = fib2(10), fib3 = fib3(10))

# A little function that times another function at the points 1:25.
timeit = function(f, pts = 1:25) {
  sapply(pts, function(x) {
    bench = microbenchmark(f(x), n = 20)
    median(bench$time)
  })
}

# Time each function.
times = lapply(list(fib1, fib2, fib3), timeit)
names(times) = c("fib1", "fib2", "fib3")
times = do.call(cbind, times)
times = as.data.frame(times)

# Some graphics showing the difference in times.
# fib1 is exponential time while fib2 is linear
matplot(times, type = "b")

# Hide the exponential fib1 times to show that fib3 is constant time.
matplot(times[-1], type = "b")




