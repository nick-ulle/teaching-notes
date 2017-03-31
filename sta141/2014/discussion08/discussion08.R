# discussion08.R

# Office Hours
# ============
#
# EXTRA OFFICE HOURS: Today 5-6pm Olson 205
#
# Next week (Thanksgiving):
#   Charles:  MW    8 - 9am     MSB 1117
#   Nick:     M     9 - 10:30am MSB 1117
#             W     ---         ---
#   Duncan:   T     See Piazza  MSB 4210
#
# Homework 3 will be returned during Monday's
# office hours.
#
# Regular office hours resume Monday 12/1.
#

# General Classification Hints
# ============================

### Hint 1 ###
# A confusion matrix shows counts for true class
# against predicted class:
#
#       pred    spam    ham
#   true
#   spam        10      20
#   ham         11      31
#
# Correct predictions are on the diagonal.

# Could estimate prediction error by
# (11 + 20) / (10 + 20 + 11 + 31)
# Not a very good estimate! Cross-validated
# estimate is better.

# k-Nearest-Neighbor Hints
# ========================

### Hint 1 ###
# Use scale() to convert variables to their
# z-scores.

data = data.frame(x = rnorm(10, 100, 2),
                  y = rnorm(10))
data
scale(data)

# This puts all variables on the same scale,
# so they're considered equally by k-NN.


### Hint 2 ###
# Use the dist() function to calculate distances.
x = matrix(c( 0,  0,
              0,  1,
              1,  1,
             -4,  0,
             -5, -0), ncol=2, byrow=T)
x

plot(x, cex=3, col='blue', asp=1,
     xlab='x', ylab='y')
text(x[, 1], x[, 2])

 # Euclidean distance (p = 2).
dist(x, upper=T)

# Manhattan distance (p = 1).
dist(x, method='manhattan', upper=T)

# Chessboard distance (p = Inf).
dist(x, method='maximum' , upper=T)

# Other Minkowski distances (p >= 1).
dist(x, method='minkowski', upper=T, p=1.5)

### Hint 3 ###
# Get nearest points with apply() and order().

dists = dist(x, upper=F)
dists = as.matrix(dists)

nearest = apply(dists, 2, order)
nearest
nearest[2:3, ]

# Make this a function!

# Cross-validation Hints
# ======================

### Hint 1 ###
# Here's how to split a vector (or data frame)
# into n pieces of nearly equal length.
x = rep(1, 21)
x
n = 5

groups = rep(1:n, length=length(x))
groups
split(x, groups)

# Again, make this a function!

### Hint 2 ###
# Only compute the k-NN distance matrix once.
# For each CV fold, look up the distances needed
# in the pre-computed matrix.

get.nearest.neighbors = function(k, test.idx, ord)
    # Get the k nearest neighbors for test points.
    #
    # Args:
    #   k           number of nearest neighbors
    #   test.idx    indexes of test points
    #   ord         pre-computed order matrix
{
    # Subset to test point columns.
    ord = ord[, test.idx]

    # Drop test point rows, for each column.
    nn = apply(ord, 2, drop.first, drop=test.idx)

    # Only return the k nearest neighbors.
    nn[seq_len(k), ]
}

drop.first = function(x, drop)
    # Remove the first instance of each value.
    #
    # Args:
    #   x       vector to drop values from
    #   drop    values to drop
{
    x[-match(drop, x)]
    # Note that
    #   x[-which(x %in% drop)]
    # would drop all instances, but it's slower.
}

dists = as.matrix(dist(x))
ord.mat = apply(dists, 2, order)
ord.mat

test = sample(1:5, 2)
test
get.nearest.neighbors(2, test, ord.mat)


# 8 Notes About Style
# ===================

### 8 ###
# `== TRUE` is redundant!
TRUE == TRUE

do.print = TRUE
if (do.print == TRUE) cat("Hello!\n")
if (do.print) cat("Hello! This works even",
                  "without == TRUE!\n")

### 7 ###
# `== FALSE` should be expressed using the "not"
# operator, `!`.
!TRUE
!FALSE

use5 = FALSE
if (use5) 5 else 7

if (!use5) 7 else 5

### 6 ###
# Check if any elements of a vector are TRUE with
# any(), not sum().
isSpam = c(FALSE, FALSE, TRUE)
any(is.spam)

# any() is not just clearer, it's also more
# efficient.

### 5 ###
# Similarly, all() will return whether all
# elements of a vector are TRUE.
isSpam
all(is.spam)


### 4 ###
# Document your functions. A good template is:

foo = function(x, y)
    # <one-sentence description of foo>
    #
    # <optional, longer description of foo>
    #
    # Args:
    #   x   <description of x>
    #   y   <description of y>
    #
    # Returns:
    #   <short description of returned value>
{
    # foo's code goes here...
}

capitalize = function(letter, strings)
    # Capitalize a specific letter.
    #
    # Args:
    #   strings vector of strings to capitalize
    #   letter  lowercase letter to capitalize
    #
    # Returns:
    #   A vector of strings, with the letter
    #   capitalized.
{
    gsub(letter, toupper(letter), strings)
}

capitalize('x', 'xylophone')
capitalize('z', 'San Diego zoo')

### 3 ###
# Don't define functions inside other functions.
add.sample = function(x, m) {
    # Sample m values from x and sum them.
    make.sample = function(y, n) {
        # Sample n from the vector y.
        sample(y, n, replace=TRUE)
    }

    sum(make.sample(x, m))
}

# Why?

# Every time add.sample() is called, it redefines
# make.sample() the same way. This is not
# efficient!

# Since make.sample() is local to add.sample(),
# no other functions can use make.sample(). This
# prevents code reuse. It also means we can't
# test make.sample() alone.

# How to fix it?
make.sample = function(y, n) {
    # Sample n from the vector y.
    sample(y, n, replace=TRUE)
}

add.sample = function(x, m) {
    # Sample m values from x and sum them.
    sum(make.sample(x, m))
}

### 2 ###
# Don't use global variables.
x = c(7, 7, 7)
double.mean = function() 2 * mean(x)
# Only works for x:
double.mean()
# What if we want the doubled mean of y?
y = c(5, 5, 5)

tmp_x = x
x = y
double.mean()
x = tmp_x
rm(tmp_x)

x
y

# That was gross! Instead, use a parameter.
double.mean = function(v) 2 * mean(v)
double.mean(x)
double.mean(y)

# Now we can reuse double.mean() with whatever
# data we want.

# One way to get in the habit of not using global
# variables is to use a source() and main()
# workflow.

### 1 ###
# Don't repeat yourself (DRY)!

# This applies in many different programming
# contexts. Let's just look at one:
#   No function is an island.

# Functions should be self-contained and avoid
# using global variables, but that doesn't mean
# they can't work together!

msg = c("From: dtemplelang@ucdavis.edu",
        "To: naulle@ucdavis.edu",
        "Subject: Work Harder!!!",
        "",
        "Hi Nick,",
        "",
        "Why isn't homework 3 graded yet?!",
        "",
        "D.")

# Many people did this:
extract.header = function(email) {
    # Possibly some code to load the email file.
    # ...

    first.blank = match("", email)
    header = email[seq(1, first.blank)]

    con = textConnection(header)
    header = read.dcf(con)
    close(con)

    header[1, ]
}

extract.body = function(email) {
    # Possibly some code to load the email file.
    # ...

    first.blank = match("", email)
    email[seq(first.blank + 1, length(email))]
}

extract.header(msg)
extract.body(msg)

# This works, so it's not terrible, but it's got
# some inelegant, repeated code.

# Here's a better strategy:
load.email = function(path) {
    # Some code to load the email file.
    # ...
}

split.email = function(email) {
    # Get first blank.
    first.blank = match("", email)

    # Split the email.
    header.lines = seq(1, first.blank)
    header = email[header.lines]
    body = email[-header.lines]

    list(header=header, body=body)
}

process.header = function(header) {
    # Use a textConnection to read the DCF format
    # header.
    con = textConnection(header)
    header = read.dcf(con)
    close(con)

    header[1, ]
}

# msg = load.email('/blah/blah/blah')
msg.parts = split.email(msg)
header = process.header(msg.parts$header)

msg.parts
header

