# STA 141a
# ========
# TA: Nick Ulle
#     naulle@ucdavis.edu
#
# Office Hours:
#   Ben           M     2-4         MSB 1117
#   Nick          M     4-6         EPS 1317
#   Prof. Gupta   TR    1:30-3:30   MSB 4240
#   Jiahui        W     10-12       Academic Surge 2142

# Infographic:
#   https://flowingdata.com/2016/05/17/the-changing-american-diet/

# Reminders:
#
# * Use Piazza!
#
# * Start the assignment early!
#
# * Data Science Initiative
#     http://dsi.ucdavis.edu/
 

# From last week:
#
# Is a Microsoft Word file human-readable? No.
#
# What about a PDF? Sort of; it has human-readable and binary parts.

# Types & Classes
# ---------------
# Every value in R has a unique "type" that describes how
# it's stored in memory.
#
# You can check the type of a value with `typeof()`.

typeof(1)
typeof(1.1)

typeof(4)
typeof(4L)

typeof("hello class")
typeof('hello class')

# If quotes appear inside a string, choose the other kind
# for the outer quotes.
"Don't do it"

`Hello` # backticks for name of var or func, not a string

# Values also have one or more "classes" that determine how
# they act.
#
# You can check the class of a value with `class()`.

class("hi")
class(c("hi", "hello"))

class(4.1)

# For vectors, the class is always the same as the type
# (except numeric/double).

class("hi")
typeof("hi")

# Factors are an interesting case:
x = factor(c("A", "B", "A", "A", "B", "C", "C"))
x

class(x)
typeof(x)

# You can reset the class of a value with `unclass()`.
#
# This can be educational but is not very useful.

unclass(x)

class(unclass(x))

# TYPE answers WHAT IS IT?
# CLASS answers HOW DOES IT ACT?
#
# For example:
#
# I'm a person. That's what I am -- my type.
#
# But I'm also a student, a cat papparazzo, and a hiker.
# Those are things I do -- my class(es).


# Be cautious about assuming:
#
#   factor  => categorical
#   integer => discrete
#   numeric => continuous
# 
# Not always true.
#
# You're a better statistican than R. Use your brain to
# decide!


# Subsets & Extraction
# --------------------
dogs = readRDS("data/dogs/dogs_top.rds")

typeof(dogs)
class(dogs)

# Multiple ways to get values from a data frame.
#
# 1. Subset operator `[` and function `subset()`

dogs[1, ]
dogs[, 4]

dogs[, "weight"]

names(dogs)
colnames(dogs)
rownames(dogs)

# Also works with vectors:

dogs[c(3, 3, 2), ]

# Also works with conditions (logical vectors):

dogs[dogs$weight > 25 & dogs$height <= 10, ]
dogs[dogs$weight > 25 | dogs$height <= 10, ]

dogs[dogs$weight %in% c(25, 45, 65), ]

dogs$weight > 25

dogs$weight == 25
dogs$weight

mean(dogs$weight, na.rm = TRUE)

dogs45 = dogs[dogs$weight == 45, "breed"]
na.omit(dogs45)

dogs$breed[dogs$weight == 45]

# Don't use `which()` here, you usually don't need it!
#
# The exception is that `which()` can be used to drop NAs.

dogs[which(dogs$weight == 45), "breed"]

# 2. Extraction operator `$`
dogs$weight

# Which allows partial matching:
dogs$wei

# And works with strings:
dogs$"weight"

# 3. Extraction operator `[[`

dogs[["weight"]]

dogs[[1]]

dogs[[1, 2]]

dogs[[1, ]]

# How is subsetting different from extraction?
#
# Subset operator `[` gives back something with the same
# class.
#
# Extraction operators `$` and `[[` give back a vector.
#
# Visual aid:
#
#   https://pbs.twimg.com/media/CO2_qPVWsAAErbv.png
#

class(dogs[1])
class(dogs[[1]])


# Making Plots
# ------------
# 3 kinds of plots: base R, lattice, ggplot2
# 
# What plot is appropriate?
# 
# Feature     | Versus      | Plot
# ----------- | ----------- | ----
# categorical |             | bar, dot
# categorical | categorical | bar, dot, mosaic
# numerical   |             | box, density, histogram
# numerical   | categorical | box, density
# numerical   | numerical   | line, scatter, smooth scatter
#
#
# Base R functions for making plots:
# 
# Function           | Purpose
# ------------------ | -------
# plot()             | general plot function
# barplot()          | bar plot
# dotchart()         | dot chart (use instead of bar plot or pie chart)
# boxplot()          | box and whisker plot
# hist()             | histogram
# plot(density(...)) | density plot
# mosaicplot()       | mosaic plot
# pairs()            | matrix of scatterplots
# matplot()          | grouped scatterplot
# smoothScatter()    | smooth scatterplot
# stripchart()       | one-dimensional scatterplot
# curve()            | plot a function
#
#
# Functions for customizing plots:
# 
# Function | Purpose
# -------- | -------
# lines()  | add lines to a plot
# arrows() | add arrows to a plot
# points() | add points to a plot
# abline() | add straight lines to a plot
# legend() | add legends to a plot
# title()  | add title or labels to a plot
# axis()   | add axes to a plot
#
#
# Plot Parameters -- see `?par()`
#
# Name  | Description
# ----- | -----------
# col   | line/point color
# lty   | line type (solid, dotted, dashed)
# lwd   | line width
# mar   | margin size (bottom, left, top, right)
# mfrow | dimensions for matrix of plots; default c(1, 1)
# pch   | point character
# xpd   | clipping (`FALSE` clip to plot; `NA` no clipping)
#
# The `xpd` parameter is useful when adding a legend.
#
# See this page for more notes about making plots:
#
#   https://github.com/2016-ucdavis-sts98/notes/blob/master/graphics_guide.md
#
# The lecture will mainly cover how to use base R plots.
