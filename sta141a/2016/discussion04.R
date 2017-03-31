# discussion04.R

# Week 3
# ------
# For those interested:
#
# > Getting Started with Git, GitHub, and Bash
# > Today 1:30 - 2:30 in MSB 1147
#
# Git is a _version-control system_. When you write a term paper, you probably
# write several drafts (versions) to work out all the bugs. Programs have a lot
# more bugs, so they take a lot more drafts!
#
# Git keeps track of drafts, so you don't end up with this:
#
#   program1.R
#   program1_FINAL.R
#   program1_FINALv2.R
#   program1_FINALv2_FOR_REAL.R
#   program1_v2_FIXED_TYPO.R

# Q: How do I install a package?
#
# A: To install "tidyverse", for example, you write

install.packages("tidyverse")

# Also see week 0 discussion for more on installing.


# How To Solve Problems
# ---------------------
# (Or: "Writing Functions")
#
# Break the problem into small steps. Each step is a short function. Why?
#
# 1. Divide & Conquer: small steps are easier to work out correctly.
#
# 2. Testing: make sure each step works before moving on to the next.
#
# 3. Reuse: some steps may be useful for solving other problems.
#
#
# Problem-solving Checklist:
#
# 1. What do you want to do? You can't write the code if you don't understand
#    the problem!
#
#    Work out a simple example by hand (yes, by hand). Draw pictures.
#
# 2. Are there any built-in functions that help solve the problem?
#
# 3. Start by programming the example you worked out by hand.
#
# 4. Generalize your code. How does it break? Fix it!


# Scoping
# -------
# When you assign a variable...
#
# ...outside a function, it's a global variable.
#
# ...inside a function, it's a local variable.
#
# Functions look for local variables first.

x = 5

foo = function() {
  x = 3
  return (x)
}
foo()


foo = function() {
  # Don't use <<-
  # Return output instead!
  x <<- 3

  return (x)
}

foo()
x

# In general, R functions have no side-effects.
x = 5
bar = function() {
  return (x)
}
bar()

# Scope works from inside out
f = function() {
  g = function() {
    return (x)
  }

  return (g())
}
f()

# Scope is not shared between functions
f = function() {
  z = 3
}

g = function() {
  return (z)
}
f()
g()

x = 42
f = function(x) {
  return (x)
}
f()

# Avoid using global variables! They make your code more difficult to read.


# Debugging
# ---------
# Sales pitch:
#
# > Have errors got you down? Can't figure out what went wrong?
# >
# > Get browser() today! :D

?browser

# The browser() function pauses R.
#
# Controls:
#   Q - quit
#   n - execute next line
#   c - unpause
#   where - print stack trace
#   help - get help

f = function() {
  browser()
  x = 5
  y = rbinom(1, 5, 0.5)
  x = x + y
  x = x * x
  return (x + y)
}
f()


# Loops
# -----
# Often you'll need to do the something over and over.
#
# DRY: DON'T REPEAT YOURSELF!
#
# Programming languages are designed to automate your work. So why would you
# copy and paste?
#
# Try these strategies, in order:
#
# 1. vectorization (fastest)
# 2. apply functions
# 3. for- & while-loops
#
# When is a for-loop (or while-loop) needed?
# Only when each iteration depends on the previous iteration.

# ### Example
# Print "Hello 1!", ..., "Hello 3!".
# You could write...
cat("Hello 1\n")
cat("Hello 2\n")
cat("Hello 3\n")

# Imagine if you were asked to print "Hello 1!" to "Hello 1000000!".
#
# Write a loop! First identify how many iterations there are:
# Next add the code that's the same for each iteration:
# Finally, use the iteration number to fill in the part that changes on every
# iteration:

for (i in 5:10) {
  cat("Hello ", i, "\n")
  #cat(sprintf("Hello %i\n", i))
}

texts = c("Hello", "Goodbye")

for (i in seq_along(texts)) {
  cat(sprintf("%s\n", texts[[i]]))
}

# Better to iterate directly over the vector:
for (text in texts) {
  # browser()
  cat(sprintf("%s\n", text))
}


# Apply Functions
# ---------------
# Apply functions are more efficient but less flexible than for loops.

# lapply:
#   Apply a function to each element of a vector.
#
#   lapply(DATA, FUNCTION, ...)

x = c(1, 2, 3)
lapply(x, sin)

for (elt in x)
  print(sin(elt))

# Better to use vectorization, if the function is vectorized.
sin(x)

# Data frames are lists!
dogs = read.csv("data/dogs.csv", skip = 3)

lapply(dogs, class) # class of every column

lapply(dogs[-3], mean, na.rm = TRUE) # mean of every column

# sapply:
#   Apply a function to each element of a vector, simplifying the result.
#
#   sapply(DATA, FUNCTION, ...)

result = sapply(dogs[-3], mean, na.rm = TRUE)
names(result)
result["age"]

sapply(dogs, class)

# sapply() can still return lists in some cases!
sapply(c("a", "b"), function(elt) {
  if (elt == "b")
    return (sin)
  else
    return (3)
})

# Useful for non-interactive programming (if you write a script that runs on
# its own). Also slightly faster than sapply().
vapply(c("a", "b"), function(elt) {
  if (elt == "b")
    return (sin) # unexpected result
  else
    return (3)
}, numeric(1))

# You don't need explicit indexes with the apply functions!
people = list("Aoran", "Haoran", "Nick")

# BAD:
sapply(1:3,
  function(i) {
    sprintf("Hello %s", people[[i]])
  }
)

# GOOD:
hellos = sapply(people,
  function(person) {
    sprintf("Hello %s", person)
  }
)


# Often it's clearer to write the function separately:
say_hello = function(person) {
  sprintf("Hello %s", person)
}

sapply(people, say_hello)

# Now for a detour...
# split:
#   Split the rows of a data frame into groups,
#   according to one or more factors.
#
#   split(DATA, GROUPING)

split(dogs, dogs$breed)

# Keep NAs
dogs$breed = factor(dogs$breed, exclude = NULL)

by_breed = split(dogs$speed, dogs$breed)
by_breed

sapply(by_breed, mean)

# tapply:
#   Split the rows of a data frame into groups,
#   according to one or more factors, and then apply a
#   function to each group.
#
#   Equivalent to split() followed by sapply().
#
#   tapply(DATA, GROUPING, FUNCTION)

by_breed = split(dogs$speed, dogs$breed)
sapply(by_breed, mean, na.rm = TRUE)

# Same thing:
tapply(dogs$speed, dogs$breed, mean, na.rm = TRUE)

# mapply:
#   Apply a function to each element, for two or more
#   vectors simultaneously.
#
#   mapply(FUNCTION, ..., ARGS)

data = list(a = 1:3, b = 5:9)
idx = c(1, 2)

mapply(function(x, i) x[[i]], data, idx)

# For more about apply functions, see:
# <http://stackoverflow.com/a/7141669>
