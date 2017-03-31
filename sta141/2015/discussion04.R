# discussion04.R

# Office Hours
# ============
# Nick:     M   4 - 6pm       EPS 1316
# Duncan:   T   ???           MSB 1147
#           R   ???           MSB 1147
# Michael:  F   9 - 11am      MSB 1147


# Feedback
# ========
#
# Feedback on Assignment 1, part 1 is posted to
# Piazza! Read it!
#
# Also: rubric is posted to Piazza.
#
# Other advice:
# * Avoid assign() and get()
# * It's okay to use dplyr, but in some cases it's
#   more difficult than base R commands
# * Make informative plots, and don't print more than
#   necessary.


# Writing Functions
# =================

# Use parameters for function inputs.
say_something = function(x) {
  # x is the input.

  # Last line gets returned as output.
  # Or explicity return output with return()
  sprintf("%s says this is the output", x)
}

say_something("Duncan")

# Avoid using global variables in functions!

# BAD:
f = function() x^2

f = function() {
  x^2
}

f = function() {
  return(x^2)
}

x = 5
f()

# GOOD:
f = function(x) x^2

f(5)


# Reading Files
# =============

# For tabular data:
#   read.table()  -- general tabular data
#   read.csv()    -- comma-separated data
#   read.delim()  -- tab-separated data

# Other goodies:
#   read.fwf()  -- fixed-width data
#   scan()      -- scan for values

# read.table() reads tabular data.
dogs = read.table('dogs.txt')
?read.table

# read.csv() reads comma-separated values (CSV) data.
read.csv('dogs.csv', row.names = 1)
?read.csv


# What if data isn't in a nice format?

# The scan() function scans a file for the specified
# values.
scan(n = 1)

scan(n = 2, what = character())

scan(n = 2, what = "hi")

scan(n = 2, what = list("integer", integer()))

scan("filename.txt", n = 3, what = ___)

scan("courses.txt", what = list("", 1L, 0i), nmax = 1)

# The readLines() function reads a specified number of
# lines from a file.
readLines("courses.txt")

readLines("courses.txt", n = 2)

readLines("courses.txt", n = 1)

# If you want to save your place in the file, use a
# connection first!

# Connections:
#   file()  -- opens a local file
#   url()   -- opens an internet file
#   textConnection() -- opens a string as a file
?file

# The file() function opens a file. Close it when
# you're done!
con = file('courses.txt', open='rt')
?file

# Now readLines() will keep track of what's already
# been read.
readLines(con, 1)
?readLines

# Read all remaining lines.
readLines(con)

# Close a file with close().
close(con)


# Apply Functions
# ===============
# Apply functions are more efficient but less flexible
# than for loops.

# lapply:
#   Apply a function to each element of a vector.
#
#   lapply(DATA, FUNCTION, ...)

x = c(1, 2, 3)
lapply(x, sin)

for (elt in x) print(sin(elt))

# Better to use vectorization, if the function is
# vectorized.
sin(x)

# Data frames are lists!
lapply(dogs, class)

lapply(dogs, mean)

l_means = lapply(dogs[-3], mean, na.rm = TRUE)
l_means
class(l_means)


# sapply:
#   Apply a function to each element of a vector,
#   simplifying the result.
#
#   sapply(DATA, FUNCTION, ...)

sapply(dogs, class)

s_means = sapply(dogs[-3], mean, na.rm = TRUE)
s_means
class(s_means)

# You don't need explicit indexes with the apply
# functions!

people = list("Duncan", "Yuki", "Michael", "Nick")

# BAD:
sapply(1:4, function(i) {
  sprintf("Hello %s", people[[i]])
})


# GOOD:
hellos = sapply(people, function(person) {
  sprintf("Hello %s", person)
})

# Any cases where we'd want to use indexes?

# Subset vector or reorder vector
hellos[c(2, 1, 3, 4)]

# Loop over multiple vectors at once
# -> use mapply()

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

f = function(x, y) x * y^2
a = c(5, 3, 6)
b = c(2, 1, 5)

mapply(f, a, b)

# Another example:
people = list("Duncan", "Yuki", "Michael", "Nick")
statuses = list("busy", "busier", "teaching", "teaching")

mapply(function(person, status) {
  sprintf("%s is %s!", person, status)
}, statuses, people)

# You can also apply a function to...
#   + rows or columns of a matrix (apply)
#   + each element, recursively (rapply)
#   + each element, efficiently (vapply)
#
# See the StackOverflow post!


# Assignment 2 Strategy
# =====================
#
# Write one or more functions for each step!
#
# Design your functions to handle a single file!
# Just one!
#
# Then use apply functions to run them on every file.

