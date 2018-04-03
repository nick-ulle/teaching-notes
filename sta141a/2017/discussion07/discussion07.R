# STA 141a
# ========
# TA: Nick Ulle
#     naulle@ucdavis.edu
#
# Office Hours:
#   Ben           M     2-4         MSB 1143
#   Nick          M     4-6         EPS 1317
#   Prof. Gupta   F     1-5         MSB 4240
#   Jiahui        F     3:30-5:30   MSB 1143

# NOTE: Nick will not have office hours on Nov 27.
#
# Instead there will be extra office hours later that week
# (to be announced soon on Piazza).


# Infographic:
#   http://demographics.coopercenter.org/racial-dot-map/


# How To Solve Problems
# ---------------------
# (Or: "How To Write Functions")
#
# Break the problem into small steps. Why?
#
# 1. Divide & Conquer: small steps are easier to work out
#    correctly.
#
# 2. Testing: make sure each step works before moving on to
#    the next.
#
# 3. Reuse: some steps may be useful for solving other
#    problems.
#
#
# Problem-solving Checklist:
#
# 1. What do you want to do? You can't write the code if
#    you don't understand the problem!
#
#    Work out a simple example by hand (yes, by hand). Draw
#    pictures.
#
# 2. Are there any built-in functions that help solve the
#    problem?
#
# 3. Start by programming the example you worked out by
#    hand.
#
# 4. Generalize your code. How does it break? Fix it!


# Loops
# -----
# There are 4 different ways to write a loop:
#
# 1. Vectorization
sin(c(1, 2, 3))

# 2. Apply Functions (including `replicate()`)
sapply(c(1, 2, 3), sin) # repeat something with argument(s)
replicate(3, sample(1:10)) # repeat something; no argument

# 3. While/For Loops
x = numeric(3)
for (i in c(1, 2, 3))
  x[i] = sin(i)

x = numeric(3)
i = 1
while (i <= 3) {
  x[i] = sin(i)
  i = i + 1
}

# 4. Recursion
f = function() f()

# Generally you should try these from top to bottom. Also:
#
# * Write apply functions that iterate over elements, not
#   indexes.
#
#   BAD:
lapply(1:ncol(iris), function(i) class(iris[[i]]))

#   GOOD:
lapply(iris, class)

#
# * If your problem is sequential (the next item depends on
#   the previous item) then a for loop is usually the
#   simplest solution.
#
#   i1 <- i2 <- i3 <- i4
#
# * If you save values in a for loop, allocate memory
#   before the loop.
#
#   BAD:
x = c(1)
for (i in 2:10)
  x[i] = x[i - 1] + rnorm(1, i)

#   GOOD:
n = 10
x = numeric(n)
for (i in 2:n)
  x[i] = x[i - 1] + rnorm(1, i)

# * If you write a for loop `for (i in x)` and never use
#   `i`, then your problem is definitely not sequential.
#   Use  vectorization or an apply function instead.
#
#   BAD:
for (i in 1:3)
  message("Hello")

#   GOOD:
replicate(3, message("Hello"))

#
# * If your problem is a tree then recursion is usually the
#   simplest solution.
#
#         i4
#        /
#      i2
#     /
#   i1    i5
#     \  /
#      i3
#        \
#         i6
#


# Debugging
# ---------
# Sales pitch:
#
# > Have errors got you down? Can't figure out what went
# > wrong?
# >
# > Get browser() today! :D

?browser

x = 0
for (i in 1:20) {
  x = cos(x)
  if (i == 12)
    browser()
}

# The browser() function pauses R.
#
# Controls:
#   Q - quit
#   n - execute next line
#   c - unpause
#   where - print stack trace
#   help - get help

f = function() {
  x = 5
  browser()
  sin(10)
  log(10)
}

f()

# The debugging functions are especially useful for
# understanding what happens in each iteration of a loop.

for (i in 1:4) {
  browser()
  message = paste0('This is iteration ', i)
  print(message)
}

sapply(1:4, function(x) {
  browser()
})
