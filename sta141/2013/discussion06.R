# discussion06.R

# ----- Midterm Questions? -----

# Question 6:
fInv <- function(y, a, b, c) {
  out <- numeric(length(y))
  
  cond <- (0 <= y) & (y < (c-a) / (b-a))
  out[cond] <- sqrt(y[cond] * (b-a) * (c-a)) + a
  
  cond <- ((c-a) / (b-a) <= y) & (y <= 1)
  out[cond] <- b - sqrt((1-y[cond]) * (b-a) * (b-c))
  
  cond <- (y < 0)
  out[cond] <- 0
  
  cond <- (y > 1)
  out[cond] <- b
  
  out
}

y <- seq(0.1, 1, 0.1)
a <- 1
b <- 3
c <- 2
fInv(y, a, b, c)

# ----- Debugging -----
# The one debugging function you should make sure
# to remember is browser().

# The browser function tells R to "pause" at that
# line and let you use the console.

browser()

# n -- executes only the next line.
# where -- tells you what the next line is.
# c -- resumes execution.
# Q -- quits the browser.

f <- function(data) {
  x <- 5
  n <- sd(data) / mean(data)
  browser()
  n <- 1
  n <- 2
  n <- 3
}

f(1:5)

# You can use if statements to create conditional
# breakpoints.

f <- function() {
  m <- 0
  for (i in 1:100) {
    if (i == 95)
      browser()
    m <- m + i
  }
  m
}

f()

# The recover function is simular, but prints
# a stack trace, showing how R got to the point
# where it paused.

f <- function(data) {
  a <- data * 5
  recover()
  a
}

g <- function() {
  a <- 6
  f(a)
}

g()

# Setting the error option will make R
# automatically run browser or recover when
# there's an error.
options(error = browser)

f <- function() {
  a <- 1:3
  b <- 1:10
  data.frame(a, b)
}

f()

options(error = recover)

f()

options(error = NULL)

# Other useful debugging functions are trace,
# debug, and undebug.

# ----- Iteration -----

# The debugging functions can be useful for 
# understanding what happens in each iteration
# of a loop (for, while, sapply, tapply, etc).

a <- 2 * (1:100) + 17
b <- integer(100)

for (i in 1:100) {
  browser()
  b[i] <- a[i]
}

sapply(a,
       function(a_) {
         browser()
       })

mapply(function(a_, b_) {
         browser()
       }, a, 1:100)

# ----- ... -----
# A parameter called ... for a function is
# treated specially, and allows for calling the
# function with any number of arguments.

# Read more about it in:
?'...'
# (see 'An Introduction to R')

g <- function(x, y) {
  x + y
}

f <- function(a, ...) {
  browser()
  ..1
}

f(1, 2, 3)

# ----- Other Stuff -----

# Monte Carlo integration.
calcPi <- function(n) {
  x <- runif(n, 0, 2)
  y <- runif(n, 0, 2)
  
  inside <- (x - 1)^2 + (y - 1)^2 < 1
  4 * sum(inside) / n
}

calcPi(10)
calcPi(10^6)
