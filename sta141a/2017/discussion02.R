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
#   https://stackoverflow.blog/2017/10/10/impressive-growth-r/


# Reminders:
#
# * Extra office hours today 4-6pm EPS 1317
#
# * Data Science Initiative
#     http://dsi.ucdavis.edu/
#
# * R Graph Gallery
#     http://www.r-graph-gallery.com/
#
# * Graphics Checklist
#
# * Rubric
 

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
# cex   | text size
# las   | text rotation
#
# The `xpd` parameter is useful when adding a legend.

dogs = readRDS("data/dogs/dogs_full.rds")

head(dogs)

# Can we recreate the dogs plot?
palette = c(
  "#E69980"
, "#695990"
, "#75A76C"
, "#C6665A"
, "#C9A01E"
, "#8E314A"
, "#3D6E6C"
)

# Save the default graphics settings.
old_par = par()

ylim = rev(range(dogs$popularity, na.rm = T))
pch = as.integer(dogs$category)
col = palette[dogs$category]
bg = "#F5ECDA"

par(mar = c(5, 4, 4, 9) + 0.1, bg = bg)
plot(popularity ~ datadog, dogs, ylim = ylim, pch = pch,
  col = col, xaxt = "n", yaxt = "n", ann = FALSE)

# Add title and axis labels separately for extra control.
title(xlab = "Score (higher is better)", line = 1)
title(ylab = "Popularity (higher is better)", line = 1)
title(main = "Best in Show")

# Add dog breed names.
text(dogs$datadog, dogs$popularity, dogs$breed, pos = 1,
  cex = 0.5, col = col)

# Add legend on right side.
par(xpd = NA)
legend(4, 0, levels(dogs$category),
  pch = seq_along(levels(dogs$category)),
  col = palette, bty = "n")
par(old_par)


# More Plot Examples
# ------------------

# Do intelligent dogs live longer?
dogs = dogs[order(dogs$intelligence_rank), ]
plot(longevity ~ intelligence_rank, dogs, type = "l")


# What kind of dog lives longest?
boxplot(longevity ~ category, dogs, las = 2)

subset(dogs, category == "toy" & longevity > 16)


plot(density(dogs$longevity, na.rm = T))

by_category = split(dogs$longevity, dogs$category)

xlim = range(dogs$longevity, na.rm = TRUE) + c(-2, 2)
ylim = c(0, 0.3)

plot(density(by_category$toy, na.rm = T),
  xlim = xlim, ylim = ylim)
lines(density(by_category$herding, na.rm = T))

# Apply Functions
# ---------------
#
# lapply:
#   Apply a function to each element of a vector.
#
#   lapply(DATA, FUNCTION, ...)

cls = lapply(dogs, class)

cls
class(cls)

# Better to use vectorization, if the function is
# vectorized.

x = c(3, 7, 9, 12)

# BAD:
lapply(x, sin)

# GOOD:
sin(x)

# sapply:
#   Apply a function to each element of a vector,
#   simplifying the result.
#
#   sapply(DATA, FUNCTION, ...)

cls2 = sapply(dogs, class)

cls2
class(cls2)

# Now for a detour...
# split:
#   Split the rows of a data frame into groups,
#   according to one or more factors.
#
#   split(DATA, GROUPING)

by_kids = split(dogs, dogs$kids)

names(by_kids)

by_kids$high

# A common pattern is split-sapply.

by_kids = split(dogs$weight, dogs$kids)
sapply(by_kids, mean, na.rm = T)

# tapply:
#   Split the rows of a data frame into groups, according
#   to one or more factors, and then apply a function to
#   each group.
#
#   Equivalent to split() followed by sapply().
#
#   tapply(DATA, GROUPING, FUNCTION)

tapply(dogs$weight, dogs$kids, mean, na.rm = T)


# Lattice
# -------
# Lattice is an alternative plotting package that is
# built-in to R (no need to install).
#
# Lattice does not work with base R plotting functions like
# `lines()`, `points()`, etc...
#
# Lattice is all about grouping and side-by-side plots
# (making a LATTICE of plots).

library(lattice)

# Use the `groups` parameter to set overlaid groups.
#
# Use `Y ~ X | GROUP` to set side-by-side groups.

densityplot(~ longevity, dogs, groups = category,
  auto.key = TRUE)

densityplot(~ longevity | category, dogs)

# You can also use both at once.

densityplot(~ longevity | category, dogs, groups = kids,
  auto.key = TRUE)

xyplot(popularity ~ datadog, dogs, groups = category)

# View current graphical settings with `show.settings()`.
show.settings()

# Get graphical settings with `trellis.par.get()`.
old_par = trellis.par.get()
names(old_par)

# Set graphical settings with `trellis.par.set()`.
trellis.par.set(
  superpose.symbol = list(col = palette),
  panel.background = list(col = bg)
)

xyplot(popularity ~ datadog, dogs, groups = category,
  auto.key = TRUE)

# Set up the legend by looking at `?simpleKey`.

key = list(columns = length(levels(dogs$category)))

xyplot(popularity ~ datadog, dogs, groups = category,
  auto.key = key, main = "Test")
