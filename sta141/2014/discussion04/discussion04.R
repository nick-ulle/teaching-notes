# discussion04.R

# Office Hours
# ============
#
# Charles:  MWF 8 - 9am     MSB 1117
# Nick:     M   4 - 5:30pm  EPS 1316
#           W   1 - 2:30pm  MSB 4208
# Duncan:   T/R Around 12?  MSB 4210

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
f(x = 1)

g = function(y) {
  # x is not defined locally
  x + 1
}

g(10)
g(y = 10)


# Functions can't see variables defined in other functions.
f = function(x) {
  local_x = x
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

g = function(y) {
  x = y
}

g(y = 10)
x

# Writing Functions
# =================

# What do you want to do? Is there a built-in function?
#
# Try writing the function for a simple/toy case first.
#
# Draw a picture of the steps on paper, to clarify each
# step.

# Example 1
# =========
# Write a rejection sampler for a univariate distribution.
f = function(x) ifelse(-2 <= x & x <= 1, dnorm(x), 0)

library(ggplot2)
plt = ggplot(data.frame(x = c(-3, 2)), aes(x = x))
plt = plt + stat_function(fun = f, n = 1000, size = 1)
plt = plt + ggtitle('Target Density')
plt

# Use Uniform(-2, 1) as our proposal distribution.
dprop = function(x) dunif(x, -2, 1) # g(x)
rprop = function(n) runif(n, -2, 1)
plt + stat_function(fun = dprop, linetype = 'dashed')

# Rescale so that the proposal density majorizes the target
# density.
C = 3 * dnorm(0) # c
plt = plt + stat_function(fun = function(x) C * dprop(x),
                          size = 1, linetype = 'dashed')
plt


# Step 1: Sample x.
x = rprop(1)

# Step 2: Sample y.
y = runif(1, 0, C * dprop(x))

# Step 3: Accept/reject.
if (y < f(x)) {
  # ACCEPT! :D
  samp = x
}
samp

# Make it a loop and wrap it in a function.
rnormtrunc = function(n) {
  samp = numeric(n)
  accepted = 0
  while(accepted < n) {
    # Step 1: Sample x.
    x = rprop(1)

    # Step 2: Sample y.
    y = runif(1, 0, C * dprop(x))

    # Step 3: Accept/reject.
    if (y < f(x)) {
      # ACCEPT! :D
      accepted = accepted + 1
      samp[accepted] = x
    }
  }
  return(samp)
}

pts = rnormtrunc(10000)

# Compute density estimate.
dens = density(pts, from = -2, to = 1)

# The target density f was missing a constant that makes it
# integrate to 1 over [-2, 1]. Rescale the density estimate
# to match.
scaling = integrate(f, -2, 1)$value

# Plot the density estimate.
plt + geom_area(aes(x = dens$x, y = dens$y * scaling),
                alpha = 0.2, fill = 'blue')
plt

# How can we make this function more general?

# How can we make this function faster?

# Example 2
# =========
# Write a function that generates positions in a random
# walk.

# Subset Operators Review
# =======================

# The subset operator [ subsets by index.
vec = c(w = 2, x = 5, y = NA, z = 2)
vec

vec[c(1, 2, 3)]

# Indexes can be repeated to get an element more than once.
vec[c(2, 2, 4, 2)]

# Indexes start from 1, and the index 0 returns nothing.
vec[c(0, 0, 2, 0)]

# Indexes that are too high return NA.
vec[c(100, 2, 1001)]

# Using NA as an index also returns NA.
vec[c(NA, 2, 3)]

# When all indexes are negative, elements get removed.
vec[c(-1, -4)]

# The entire vector is returned if no indexes are
# specified.
vec[]

# The subset operator is just a function.
'['(vec, c(1, 2))

# The subset operator can also take logical values. TRUE
# means keep an element and FALSE means do not keep it.
vec[c(TRUE, FALSE, TRUE, TRUE)]

vec[c(TRUE, FALSE)]

# The subset operator can also take names.
vec[c('x', 'z', 'z', 'x')]

# There are two extraction operators: [[ and $.
# These extract an element of a list, converting it to an
# atomic type.
ll = list(real = 1, imaginary = -3i)
ll

typeof(ll)
typeof(ll[1])
typeof(ll[[1]])
typeof(ll$real)

# The $ operator has partial matching.
ll$im

# Homework Hints
# ==============

# The function kde2d() can create 2-dimensional kernel
# density estimates. There's also a function in ggplot2
# for plotting 2d density estimates.

# The image() function is a nice alternative to contour()
# and persp().

# The raster and rasterVis packages also have useful
# functions for plotting 3d data. See raster(), levelplot(),
# and flip().

# Use rasterVis to plot f(x, y) = xy over [-1, 1] by [-1, 1]
library(rasterVis)

# Example of rasterVis to plot f(x, y) = x * y
x = seq(-1, 1, length.out = 1000)
y = x
z = outer(x, y, function(x, y) x*y)
r = raster(z)
extent(r) = c(-1, 1, -1, 1)
r = flip(r, 'y')
levelplot(r, margin = FALSE)

# The mode of the target density can be found by eyeballing
# the graph, but if you want to be more precise you can
# use an optimization function.
# Some optimization functions: nlm(), constrOptim(), optim().
# WARNING: Optimizing might be more work than just looking at
# the graph would!
