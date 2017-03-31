# discussion03.R

# Office Hours
# ============
# Come to office hours so I don't get lonely.
#
# Charles:  MWF 8 - 9am     MSB 1117
# Nick:     M   4 - 5:30pm  EPS 1316
#           W   1 - 2:30pm  MSB 4208
# Duncan:   T/R ???         MSB 4210

# Iteration
# =========
# Sample breeds for 10 dogs.
breed.names =  c('Poodle', 'Chihuahua', 'Labrador')
breed = sample(breed.names, 10, replace = TRUE)
breed

# Generate age as Binomial(n = 20, p = 0.45)
age = rbinom(10, 20, 0.45)

# Generate speed as N(11, 3^2), then round.
speed = round(rnorm(10, 11, 3), 1)

# Assemble the data frame.
dogs = data.frame(age=age, speed=speed, breed=breed)
dogs[1, 'age'] = NA
dogs[5, 'breed'] = NA

rm(breed.names, breed, age, speed)

dogs

# lapply: apply a function to each element
#     lapply(DATA, FUNCTION, ARGS)

# Dataframes are...
lapply(dogs, class)
lapply(dogs, mean)
lapply(dogs[, 1:2], mean)
a = lapply(dogs[-3], mean, na.rm = TRUE)
class(a)

# sapply: apply a function to each element, then simplify
#     sapply(DATA, FUNCTION, ARGS)

sapply(dogs, class)
b = sapply(dogs[-3], mean, na.rm = TRUE)
class(b)

# What about matrices?
A = matrix(runif(6, 0, 10), 2, 3)
A
sapply(A, mean)
lapply(A, mean)

# split: split the rows into groups
#     split(DATA, GROUPS)

split(dogs, dogs$breed)

# By default factors don't treat NA as a level.
?factor
breed.na = factor(dogs$breed, exclude = NULL)

# Compare with and without NA as a level.
dogs$breed
breed.na

dogs.by.breed = split(dogs, breed.na)
dogs.by.breed

# ....

unsplit(dogs.by.breed, breed.na)

# Something interesting:
speeds.by.breed = split(dogs['speed'], breed.na)
speeds.by.breed
sapply(speeds.by.breed, mean)

# Remember [ ] doesn't extract, but [[ ]] and $ do.
speeds.by.breed = split(dogs[['speed']], breed.na)
speeds.by.breed
sapply(speeds.by.breed, mean)

# tapply: apply a function to each group
#     tapply(DATA, GROUPS, FUNCTION, ARGS)

# tapply() is the same as split() followed by sapply()
tapply(dogs[['age']], breed.na, mean, na.rm = TRUE)

# mapply: apply a function to each element, for two or more
# vectors simultaneously
#     mapply(FUNCTION, DATA1, DATA2, ...)

f = function(x, y) x * y^2
a = c(5, 3, 6)
b = c(2, 1, 5)

mapply(f, a, b)

dogs
mapply(max, dogs$speed, dogs$age)

mapply(max, dogs$speed, dogs$age,
       MoreArgs = list(na.rm = TRUE))

# Other apply functions:
# - apply: apply a function to rows or columns of a matrix
?apply
# - vapply: apply a function to each element, efficiently
# - rapply: apply a function to each element, recursively

# See StackOveflow post
# See plyr package

# For loops are more flexible than apply functions, but
# typically slower.

message = paste0('Hello ', 1)
message

message = paste0('Hello ', 2)
message

message = paste0('Hello ', 3)
message

for (i in c('a', 'b', 'flamingo')) {
  message = paste0('Hello ', i)
  print(message)
}


# Compute cumulative sums.
a = c(3, 2, 6, 7, 1)
cumsum(a)

cumsum2 = function(a) {
  n = length(a)
  result = numeric(n)

  result[1] = a[1]
  for (i in 2:n) {
    result[i] = result[i - 1] + a[i]
  }
  result
}

x = c(1, 3, 4)
cumsum2(x)
cumsum(x)

# Iteration 1
result[1] = a[1]

# Iteration 2
result[2] = result[1] + a[2]

# Iteration 3
result[3] = result[2] + a[3]

# Functions
# =========
# Mathematical functions use a variable to represent an
# unknown quantity.
#     f(x) = x^2

# R functions work the same way.
f = function(x) x^2

f

# The variable x doesn't need to be defined previously!

f(5)
f(x = 5)

# As long as the operations inside the function are
# vectorized, the function will be vectorized.
f(1:5)

# Functions can be more than one line by using { }.
g = function(x, y) {
  x + y
  x - y
  x^3
}

g(2)

g

# Functions are the building blocks for more sophisticated
# programs. Try to break code into short, reusable
# functions.

# Scoping
# =======
# Variables defined inside a function are called local
# variables. Functions prefer local variables, and only
# look outside if they have no other option.
x = 5

f = function(x) {
  # x is defined locally (it's a parameter)
  x + 1
}

f(1)

g = function(y) {
  # x is not defined locally
  x + 1
}

g(10)

# Functions can't see variables defined in other functions.
f = function(y) {
  local_x = y
  local_x
}

g = function(y) {
  local_x
}

f(15)
g(1)

# Functions can't change external (global) variables.
# Functions have NO SIDE EFFECTS.
x = 5

f = function(y) {
  x = y
}

f(10)
x

# Writing Functions
# =================

# What do you want to do? Is there a built-in function?
#
# Try writing the function for a simple/toy case first.
#
# Draw a picture of the steps on paper, to clarify each
# step.
