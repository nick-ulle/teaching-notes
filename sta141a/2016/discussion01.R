# discussion01.R

# STA 141a
# ========
# TA: Nick Ulle <naulle@ucdavis.edu>
#
# Please do not email unless it is a private matter!
#
#
# Some advice based on the previous 3 years:
#
# * Participation is extremely important in this course
#   because it's the main way to get help. Attend office
#   hours and USE PIAZZA!
#
# * Check Piazza for an up-to-date office hours schedule.
#
# * Show your work (your code is your work). Unlike many
#   other classes, in this one we read it.
#
# * Cite sources of ideas (including classmates). Don't
#   copy code.
#
# * Label your plots.
#
# * Although there's no mandatory style guide, it's a good idea to use one. I
#   recommend Hadley's at <http://adv-r.had.co.nz/Style.html>.


# Setup
# =====
# Download and install:
#
# * R <www.r-project.org>
#
# * RStudio <www.rstudio.com> (optional but recommended)


# A file that contains code is called a script.
#
# Save your work in scripts even BEFORE you finish!
#
# RStudio: File -> New File -> R Script (C+Shift+n)
#
# Run a line from a script with (C+Enter)


# THE MOST IMPORTANT COMMAND
# ==========================
?sin

??"linear model"


# Basics - Types
# ==============
# What kind of data can R handle?

# Numbers
5
3.1
3+2i
pi

# Logical/boolean values
TRUE
FALSE

# A sequence of characters is called a string.
#
# Strings must be single or double-quoted.
'Hello there!'
"Hello there!"

"I'm here!"

# Every object has exactly one type!
typeof(1.41)
typeof(5)

typeof(42.0)

typeof(42L) # unlikely to need this

typeof(TRUE)
typeof("Hello 141a!")

# ...these are not the only types in R.


# A vector is a collection of values that all have the same
# type.
#
# (Technically, scalar values are 1-element vectors.)
#
# Vectors can be combined.
c(TRUE, FALSE, TRUE)
c(3.1, 4.1, 5.1)
c("hi", "bye")

# A vector always has the same type as its elements.
typeof(c(3+1i, 4+0i))

typeof(c(TRUE, "HELLO"))


# A list is like a box around another value.
list(3)
typeof(list(3))

# A list can be empty.
list()

# Use a list to make a collection of values that have
# different types.
list(3, "hello")
c(list(3), list("hello"))

length(list(1, 2))
length(c(1, 2))


# Basics - Variables
# ==================
# Use `=` or `<-` to assign a value to a variable.
x = 5
x

x = 1
x

x <- 1

# Variable names must start with a letter or a dot, but can
# also include numbers and underscores.

my_variable = 12
.this.is.a.variable = 32

# List all variables in the workspace.
ls()

# Remove a variable.
rm(x)
ls()

pi = 3
rm(pi)


# Basics - Functions
# ==================
# A function takes zero or more values as input, does some
# computations, and returns a value as output.
#
# The syntax is similar to math notation...
sin(0.5)
cos(5)

# ...but not all of the functions are mathematical.
rep(5, 3)
rep(c(1, 2 ,3), 10)

?rep

# Input values are called "arguments".
#
# The output value is called the "return value".
#
# Evaluating a function is called "calling" a function.


# Operators are functions with a special syntax: they're
# written between (or before) their arguments.
1 + 1
0 - 1
2 * 2
1 / 2

abs(-3)
-3

# Exponentiation:
2 ^ 5
2 ** 5

# Since `=` is assignment, use `==` to check equality.
x == 5
x == 1

x >= -2
x <= -2

x < -2

# Use `:` to make a sequence.
1:10
?seq
seq(1, 9, 2)

# Use backticks to get help with operators.
?+
?`+`
?`%*%`

# Operators can be written with the standard syntax...
''
3 + 4
cos(3)
`+`(3, 4)

`-`(3)

`=`(y, 12)

# ...but don't do this in your code!


# The order of operations is (first to last):
# 1. function calls
# 2. PEMDAS
# 3. logic
1 - TRUE & TRUE


# A function is vectorized if it takes a vector as input and
# gets evaluated for each element.
cos(c(5, 2))

c(1, 2, 3) / 2
c(1, 2, 3) ^ 5
c(-3, 2, 1) + (-1)

# Most built-in functions are vectorized. Vectorization is
# fast, so learn to take advantage of it.
c(5, 5, 7) + c(2, 3, 2)
c(2, 2, 2) ^ c(1, 2, 3)

c(8, 9, 7) + c(1, 2)
c(8, 9) + c(1, 2, 3, 4)

# Later we'll learn how to apply non-vectorized functions
# to each element of a vector.


# Basics - Packages
# =================
# Additional functions are available in packages.
#
# Most packages are not made by the R developers, so quality
# varies!

# It's usually easy to install a package in R.

# A colorblind-friendly palette generator:
install.packages("viridisLite")

# Complete works of Jane Austen:
install.packages("janeaustenr")

# Windows users: a few packages require you to install
# Rtools first!
#
# Get Rtools at:
# <https://cran.r-project.org/bin/windows/Rtools>


# Recommended package:
install.packages("tidyverse")

# Packages only need to be installed once.
#
# Reinstall to get updates.


# Packages need to be loaded every time R is restarted.
#
# Load a package:
library("viridisLite")
