# discussion05.R

# Subset: [] [[]]
# Iterate: lapply, sapply, tapply, ...
# Operators: + - * / > <

# ----- Functions Review -----

# Mathematical functions use a variable to represent
# an unknown or changing quantity.
# f(x) = x^2

# R functions work the same way:
f <- function(x) x^2

# The variable x doesn't need to be defined previously!
# It's just a symbol used by the function. Writing
#   f(5)
# means to substitute 5 in place of x in a mathematical
# function. It means the same thing in R:
f(5)

# Multi-line functions (only last line gets returned!):
f <- function(x) {
  x^2
  x^3
}

f(2)

class(f)
typeof(f)
f

# ----- Scoping -----

# When looking for a variable, a function tries to find
# it locally first. It only looks outside if it has no
# other option.

n <- 10

f <- function(n) {
  # n is defined locally (it's a parameter).
  n
}

f(1)

g <- function(x) {
  # n is not defined locally.
  n
}

f(1)
g(1)

# Functions will not find a variable defined in a 
# different function.

f <- function(y) {
  local_x <- y
  local_x
}

g <- function(y) {
  local_x
}

f(15)
g(1)

# Functions are side-effect free. This means they
# won't change external variables!

n

f <- function(x) {
  n <- x^2
  n
}

f(2)
n

n <- f(2)

# ----- Writing Functions -----

# What do you want to do? Is there a built-in function?
#
# Try writing the function for a simple/toy case first. 
#
# Draw a picture of the steps on paper, to clarify each
# step.

# ----- Iteration -----

# 1 Before you use a iteration:
#   Do you want to do something repeatedly?
#   Can it be done with vectorization? (within reason)
#
# 2 What do you want to happen in a single iteration? 
#   Is there a built in function that does what you 
#   want? If there isn't, write and test code to handle 
#   just the first iteration.
#
# 3 Next: What are you iterating over? This is called 
#   the iterate.
#   How would your code change to handle the second 
#   iteration? 
#
# 4 Once you identify the iterate: 
#   Replace the iterate with a variable, and wrap 
#   everything in a function definition that takes the 
#   variable as a parameter.

# ----- Examples -----

# Suppose we want to find every element divible by 3
# that comes after an element not divisible by 3.
n <- c(5, 3, 9, 6, 2, 7, 3, 3, 3, 2)

# How can we simplify this problem? What if we only
# needed to find the first element satisying the
# condition?

# Get remainders after dividing by 3.
n %% 3
# Remainder is 0 when a number is divisible by 3.
(n %% 3) == 0
# Find the first number divisible by 3.
p1 <- match(TRUE, (n %% 3) == 0)
p1

# Could've also used:
which(n %% 2 == 0)[[1]]
# but match is more efficient, according to ?which.

# What can we do to find p2? We know a number not 
# divisible by 3 comes between p1 and p2. So find it:
n.tail <- n[p1:length(n)]
q1 <- match(FALSE, (n.tail %% 3) == 0)
q1
q1 <- q1 + p1 - 1
q1

# Now find p2, which is the first number divisible by
# 3 coming after q1:
n.tail <- n[q1:length(n)]
p2 <- match(TRUE, (n.tail %% 3) == 0)
p2
p2 <- p2 + q1 - 1
p2

# How can we use functions?
div3 <- (n %% 3) == 0

# This function finds the first element of v which is
# equal to is.p.
findIt <- function(v, start, is.p) {
  v <- v[start:length(v)]
  match(is.p, v) + start - 1
}

# ----- Iteration 1:
# Find first element divisible by 3.
p1 <- findIt(div3, 1, TRUE)
# Find first element after p1 not divisible by 3.
q1 <- findIt(div3, p1, FALSE)

# ----- Iteration 2:
# Find first element after q1 divisible by 3.
p2 <- findIt(div3, q1, TRUE)
# q2 <-

# What if n were longer?

# ----- Iteration 3:
# p3 <-
# q3 <-

# ----- Iteration 4:
# ...

# And so on. This is an iteration problem! How can
# we do this iteratively?

# This function finds every element divible by 3 that
# comes after an element not divisible by 3.
findDiv3 <- function(n) {
  
  div3 <- (n %% 3) == 0
  
  iteration <- 1
  
  # The first iteration needs to have q set to 1:
  q <- 1
  
  # Make a vector to store the p in. There will never
  # be more p than the length of n.
  stored_p <- rep(NA, length(n))

  repeat {
    # In each iteration:
    # Find p.
    p <- findIt(div3, q, TRUE)
    # Stop if we can't find p.
    if (is.na(p)) break
  
    # Find q after p.
    q <- findIt(div3, p, FALSE)
    # Stop if we can't find q.
    if (is.na(q)) break
  
    # Store the p we found.
    stored_p[iteration] <- p
    iteration <- iteration + 1
  }
  # Get rid of the extra NAs.
  stored_p[!is.na(stored_p)]
}

# Try out the function:
findDiv3(n)

findDiv3(c(1, 2, 4, 3, 3, 3, 3, 5, 5, 6, 7))
findDiv3(c(2, 1, 3, 3, 3))
