# discussion03.R

# Only one printed copy due for Assignment 1, Part 2.
# (to plastic bin)

# Office Hours
# ============
# Come to office hours so we don't get lonely.
#
# Nick:     M   4 - 6pm       EPS 1316
# Duncan:   T   ???           MSB 1147
#           R   ???           MSB 1147
# Michael:  F   9 - 11am      MSB 1147


# Functions
# =========
# Mathematical functions use parameters to represent
# unknown quantities.
#     f(x) = x^2

# R functions work the same way.
f = function(x) x^2

f

f(5)
f(x = 5)

# Functions can be more than one line by using { }.

# Call return() to end the function and return a value.
# Without return(), the last line is returned.
sound = function(species, x = species) {
  if (species == "cat") {
    return("Meow")
    print("Hi!")
  } else if (species == "dog")
    return("Woof")
  else if (species == "fox")
    return("WHAT DOES THE FOX SAY?")

  x
}

sound("fox", "Moo")
sound("aardvark", "Moo")
sound("aardvark")

# When specified by name, the order of the arguments doesn't
# matter.
sound(x = "Moo", species = "aardvark")


# Scoping
# =======
# When you assign a variable...
#
# ...outside a function, it's a global variable.
#    A nomadic world traveller!
#
# ...inside a function, it's a local variable.
#    Lives in the function!

# Functions look for locals first.

# These are global!
prabir = 232
duncan = 242

davis = function() {
  # prabir is local (parameters are local)
  prabir = 5
  prabir
}

davis()

davis = function(prabir) {
  # duncan is not local
  duncan
}

davis(141)

# Functions can't see variables defined in other functions.
stockton = function() {
  thomas = 243

  davis = function() {
    thomas
  }
}

max_generator = function(i) {
  x = function(...) {
    max(i, ...)
  }
}

stockton()
davis()

# Functions can't change global variables.
# Most functions have NO SIDE EFFECTS.
duncan = 242

davis = function(x) {
  duncan = x
}

davis(141)
duncan

# Assign to a global
# Don't do this!
davis = function(x) {
  duncan <<- x
}

davis(141)


# How To Write Functions?
# =======================

# A very important skill!!!
#
# Functions are the building blocks for more sophisticated
# programs. Break steps into short functions.
#   1. Easier to make sure each step works correctly.
#   2. Easier to modify, reuse, or repurpose step.
#
# What do you want to do? Explain to yourself in a comment.
#
# Is there a built-in function?
#
# Write the function for a simple or "toy" case first.
#
# Draw a picture of the steps on paper.


# Simple Debugging
# ================

# Errors in the middle of a function got you down?
# Can't seem to figure out what went wrong?
# Then browser() is your new best friend! :D

# The browser() function pauses execution. Control with:
#   Q - quit
#   n - execute next line
#   c - unpause
#   where - print stack trace
#   help - get help
?browser

euclidean = function(x, y)
{
  browser()
  dist = squared_diff(x, y)
  dist = sum(dist)
  dist = sqrt(dist)
  return(dist)
}

squared_diff = function(x, y)
{
  diff = abs(x - y)
  diff_sq = diff^2
  return(diff_sq)
}

euclidean(c(0, 0), c(1, 1))

options(error = recover)
options(error = NULL)

# How To Write Loops?
# ===================

# Write the code for 2 - 3 iterations.
#
# How is each different?
#
# How is each the same?
#
# Use browser() if you want to check on an iteration.

message = paste0('Hello ', 1)
message

message = paste0('Hello ', 2)
message

message = paste0('Hello ', 3)
message

for (i in c("World", "Class", "")) {
  message = paste0('Hello ', i)
  print(message)
  if (i == "")
    browser()
}

lapply(c("World", "Class", ""),
       function(i) {
         message = paste0("Hello", i)
         print(message)
       })

# New loop
s = numeric(3)
for (i in 1:3) {
  if (i == 1)
    s[i] = 7
  else
    s[i] = s[i - 1] + 1
}

# Same idea for apply functions!


# Detour: Making Toy Data
# =======================
# Sample breeds for 10 dogs.
breed_names =  c('Poodle', 'Chihuahua', 'Labrador')
breed = sample(breed_names, 10, replace = TRUE)
breed

# Generate age as Binomial(n = 20, p = 0.45)
age = rbinom(10, 20, 0.45)

# Generate speed as N(11, 3^2), then round.
speed = round(rnorm(10, 11, 3), 1)

# Assemble the data frame.
dogs = data.frame(age = age, speed = speed, breed = breed)
dogs[1, 'age'] = NA

rm(breed_names, breed, age, speed)

dogs


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

# Now for a detour...
# split:
#   Split the rows of a data frame into groups,
#   according to one or more factors.
#
#   split(DATA, GROUPING)

split(dogs, dogs$breed)

by_breed = split(dogs, dogs$breed)
by_breed

# ....

unsplit(by_breed, dogs$breed)

# tapply:
#   Split the rows of a data frame into groups, according to
#   one or more factors, and then apply a function to each
#   group.
#
#   Equivalent to split() followed by sapply().
#
#   tapply(DATA, GROUPING, FUNCTION)

tapply(dogs$age, dogs$breed, mean, na.rm = TRUE)

# mapply:
#   Apply a function to each element, for two or more
#   vectors simultaneously.
#
#   mapply(FUNCTION, ..., ARGS)

f = function(x, y) x * y^2
a = c(5, 3, 6)
b = c(2, 1, 5)

mapply(f, a, b)

# Other apply functions:
#   + apply: apply a function to rows or columns of a matrix
#   + vapply: apply a function to each element, efficiently
#   + rapply: apply a function to each element, recursively

# See StackOveflow post (link will be posted).

