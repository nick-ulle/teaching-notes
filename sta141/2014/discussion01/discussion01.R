# discussion01.R
# 2014/10/03

# STA 141
# =======
# Professor: Duncan Temple Lang <dtemplelang@ucdavis.edu>
# Teaching TA: Nick Ulle <naulle@ucdavis.edu>
# Grading TA: Charles Arnold <cdarnold@ucdavis.edu>
#
# Office Hours:
#   + MWF 8am-9am Charles
#   + ??? Nick
#   + ??? Duncan

# To complete this course successfully, you must use Piazza!

# Getting Started
# ===============
# Download R from [www.r-project.org].
# Optionally download RStudio from [www.rstudio.com].

# To complete this course successfully, you must know how to
# create a new (blank) text file with the .R extension. If
# you need help with this, see me, Charles, or Duncan about
# it immediately.

# Getting Help
# ============

# THE SINGLE MOST IMPORTANT COMMAND IN R:
help(sin)
?sin

# You can also search the help files.
??"exponential"
??'linear model'

# Don't forget Google, Piazza, and StackOverflow.

# Mathematics Functions
# =====================

# R has the standard math operators and functions.
1 + 1

0 - 1

2 * 2

1 / 2

2 ^ 5
2 ** 5

# Logical 'and'
TRUE & TRUE
FALSE & TRUE

# Logical 'or'
TRUE | FALSE

# Exclusive or
xor(TRUE, FALSE)

# Order of operations is PEMDASL.
1 - TRUE & TRUE

# Use backticks to get help with operators.
?`+`
?`%*%`

# Other functions.
?sin
sin(0.5)
cos(5)

?log
log(pi)

# Get Euler's number.
exp(1)

?pi
pi

# Define a variable.
a = 5
a

a = 1
a

a <- 1

# Check equality.
a == 5
a == 1

a >= -2
a <= -2

a < -2

# Check what's in the workspace.
ls()

rm(a)
ls()

rm(A, B, x)
ls()

# Vectors
# =======
# Nearly everything in R is a vector!

# Combine 1-vectors into a longer vector.
a = c(1, 2, 3, 4)
a

1:4
3:6
6:3
?`:`

c(5, 7, -9, 1)

c(TRUE, TRUE, FALSE)

# Standard math operators and functions are applied to
# vectors element-by-element. This is called vectorization,
# and the functions are said to be vectorized.
c(1, 2, 3) / 2
c(1, 2, 3) ^ 5
cos(c(5, 2))
c(-3, 2, 1) + (-1)

c(5, 5, 7) + c(2, 3, 2)
c(2, 2, 2) ^ c(1, 2, 3)

c(8, 9, 7) + c(1, 2)
c(8, 9) + c(1, 2, 3, 4)

# Define a matrix with (2, 2) on the diagonal.
A = diag(c(2, 3))
A

# Extract the diagonal.
diag(A)

# Make an identity matrix.
diag(2)
diag(3)

# Define a 2 by 2 matrix with elements (1, 2, 3, 4).
B = matrix(1:4, 2)
B

matrix(1:6, 2, 3)

matrix(c(5, -5, 2, 1), 2)

# Perform matrix multiplication (as opposed to vectorized
# multiplication).
A
B
A %*% B
A %*% c(1, 2)

# Vectorized functions also work on matrices.
A * B
A + B
A / B
A ^ B

sin(A)

# Later we'll learn how to apply non-vectorized functions
# element-by-element.

# Types
# =====
# Every R object has an atomic data type.

# Check the type of a vector.
typeof(3)
typeof(3.1)
typeof(pi)
typeof(c(1, 2, 3))

typeof(1 + 0i)
typeof(1 - 5i)

typeof("Hello world!")

typeof(TRUE)
typeof(c(TRUE, FALSE))

# Functions also have a type.
typeof(sin)
typeof(typeof)

# The list type is the most general type.
typeof(c(sin, cos, tan))
typeof(c(5, "hello", TRUE, sin))

# Think of the list type as a box that can hold other types.
# Make a new list.
x = list(4, 5i, "cats")
x
typeof(x)

# Another way to make the same list. This is only for
# illustration. Never make a list this way.
x = c(list(4), list(5i), list("cats"))
x
typeof(x)

# Nested lists are okay when necessary.
list(list(4, 2, 1), list("hi", 43, 42i))

# `c()` automatically selects to the most specific type
# possible. List is the *least* specific type.
c(3, 4i, TRUE)
typeof(c(3, 4i, TRUE))

c(1, TRUE, "parrot")
typeof(c(1, TRUE, "parrot"))

typeof(c(1, sin))

# Extraction
# ==========
# Use double square brackets [[ ]] to extract a single
# element as an atomic type.
x = c('a', 'b', 'c')
x[[1]]
x[[3]]

B
B[[1, 1]]
B[[2, 1]]

# Use single square brackets [ ] to extract a vector of the
# same type.
x
x[c(1, 3)]
x[c(1, 1, 1)]
x[c(TRUE, FALSE, TRUE)]

B[1, ]

# Note that using [ ] on a list always returns a list.
y = list('a', 'b', 5)
y[c(1, 2)]
y[1]

y[[1]]
