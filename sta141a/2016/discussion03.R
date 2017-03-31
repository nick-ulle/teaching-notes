# discussion03.R

# Week 2
# ------


# Writing Functions
# -----------------
# Two ways to think about R functions:
#
# 1. As factories: raw materials (arguments) go in, a processed goods (return
#    values) come out.
#
#             +-----+
#        x -->|  f  |--> x^2
#             +-----+
#
# 2. As mathematical functions: parameters represent undetermined quantities.
#
#        f(x) = x^2
#
# You can write your own function with the `function` command. Just like any
# other object in R, you can assign functions to variables.

sq = function(x) x^2

sq(2)
sq(x = 3)
sq(y = 10)
sq()

# Surround code with curly braces `{ }` to write functions longer than one
# line.
#
# You can call `return()` to immediately exit a function and return a value.
# Subsequent code is ignored.
#
# If a function doesn't contain `return()`, the last line is returned.


# ### Example
# Write a function that returns a different string depending on the input
# string.

# Let's write a function that takes an animal name and returns the animal's
# sound (as strings).

# Get in the habit of starting programming problems by writing down the inputs
# and outputs.
#
# Here the input is an animal name and the output is an animal sound.

animal_sound = function(animal) {
  # return sound
}

# Next, write down the simplest case you want to solve. How are we going to use
# our function?

animal_sound("dog") # should return "woof"

# Now add code to make the function do what we want:

animal_sound = function(animal) {
  "woof"
}

# Can we come up with ways to break the function? Consider:

animal_sound("cat") # should return "meow"
animal_sound("fox") # should return "What does the fox say?!"
animal_sound("cow") # should return "moo" or "What does the cow say?!"
animal_sound(1)     # should raise an error
# ...

# Go back to the function and fix it, so that it works for the "bugs" and
# missing features we identified. Repeat this process of finding bugs and
# fixing them until the function does exactly what you want.
#
# For example, the final product might be:

animal_sound = function(animal) {
  animal = tolower(animal)

  if (animal == "dog") {
    return ("woof")
  } else if (animal == "cat") {
    return ("meow")
  }

  return (sprintf("What does the %s say?!", animal))
}

# The function above still doesn't work correctly for vectors. Consider

animal_sound(c("cat", "dog", "chicken"))

# It would be nice if the function were vectorized, but a function with an
# if-statement is generally not vectorized!
#
# How can we vectorize the function? Several different ways:
#
# * for/while loop
# * apply function (e.g. sapply)
# * ifelse()
# * vector operations
#
# Loops and apply functions are explained in more detail in the notes below.
#
# For example, if we use an apply function we can reuse the `animal_sound()`
# function we already wrote:

animal_sound2 = function(animals) {
  # imagine the input: c("cat", "dog", "coyote")
  sapply(animals, animal_sound)
}

animal_sound2(c("cat", "dog", "coyote"))

# On the other hand, the most efficient way to write the function is with
# vector operations:

animal_sound3 = function(animals) {
  # Default to "What does the ... say?!"
  sounds = sprintf("What does the %s say?!", animals)

  # Replace the sounds for dogs and cats with the correct sounds.
  sounds[animals == "dog"] = "woof"
  sounds[animals == "cat"] = "meow"

  return (sounds)
}

animal_sound3(c("cat", "dog", "coyote"))


# A _default argument_ is the argument a function uses when no argument is
# specified. You can set default arguments when you write a function.

f = function(x, y = 3) {
  x * y
}

# When you call a function, specify arguments by name or order.

f(1)    # no argument y, so returns 3
f(1, 2) # argument x = 2, so returns 2

# Arguments specified by name can be in any order.

f(y = 2, x = 1)


# How To Write Functions?
# -----------------------
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
# When is a for-loop needed?
# Only when each iteration depends on the previous iteration.

# ### Example
# Print "Hello 1!", ..., "Hello 3!".

# You could write...
cat("Hello 1!\n") # "\n" tells R to start a new line after printing
cat("Hello 2!\n")
cat("Hello 3!\n")

# ...but this gets boring fast!
#
# Imagine if you were asked to print "Hello 1!" to "Hello 1000000!".
#
# Write a loop! First identify how many iterations there are:

for (i in 1:3) {
  # TODO
}

# Next add the code that's the same for each iteration:

for (i in 1:3) {
  cat("Hello __!\n") # TODO: fill in the blank
}

# Finally, use the iteration number to fill in the part that changes on every
# iteration:

for (i in 1:3) {
  message = sprintf("Hello %i!\n", i) # %i stands for "substitute an integer"
  cat(message)
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

for (elt in x) print(sin(elt))

# Better to use vectorization, if the function is vectorized.
sin(x)

# Data frames are lists!
dogs = read.csv("dogs.csv", skip = 3)

lapply(dogs, class) # class of every column

lapply(dogs, mean) # mean of every column

# sapply:
#   Apply a function to each element of a vector, simplifying the result.
#
#   sapply(DATA, FUNCTION, ...)

sapply(dogs, class)

# You don't need explicit indexes with the apply functions!
people = list("Aoran", "Haoran", "Nick")

# BAD:
sapply(1:3, function(i) {
  sprintf("Hello %s", people[[i]])
})


# GOOD:
hellos = sapply(people, function(person) {
  sprintf("Hello %s", person)
})


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

# For more about apply functions, see:
# <http://stackoverflow.com/a/7141669>
