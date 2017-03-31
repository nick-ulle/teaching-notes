# discussion02.R

# Reminder: discussion notes are posted to Piazza every
# Friday night!

# Office Hours
# ============
# Introduce yourselves! Last week: ~5 people out of 100
#
# Nick:     M   4 - 6pm       EPS 1316
# Duncan:   T   11 - 12:30pm  MSB 1147
#           R   12 - 1:30pm   MSB 1147
# Michael:  F   9 - 11am      MSB 1147

# Code Style
# ==========
# Writing clean, organized code is an essential programming
# skill.
#   * Use descriptive variable names.
#   * Use spaces around operators such as +, -, *, and /.
#   * Make comments with # to explain code.
#       - Also use comments to guide your design.
#   * Check out Google's R style guide.
#
# Yuki can and will deduct points for unreadable code.

# BAD code looks like this:
hist(na.omit(subset(iris$Sepal.Length,iris$Species=='setosa'))[1:25],col=c(1,2,3,4,5))

# GOOD code looks like this:
setosa = subset(iris$Sepal.Length, iris$Species == 'setosa')
setosa = na.omit(setosa)
hist(setosa[1:25], col=1:5, main='Setosa Histogram',
  xlab='Sepal Length')

# Subsets & Sorting
# =================

# The readRDS() function loads RDS data, but you must assign
# it to a variable yourself.
quakes = readRDS('../data/quakes_subset.rds')

head(quakes)

# The syntax for the subset function is
#
#   subset(DATA, CONDITION, select = COLUMNS)
#
subset(quakes, mag >= 7.3, select = location)

# In this case, CONDITION was
quakes$mag >= 7.3

# The syntax for subsetting with [ is
#
#   DATA[CONDITION, COLUMNS, drop = FALSE]
#
q1 = quakes[quakes$mag >= 7.3, 'location', drop = FALSE]

# It's also possible to keep multiple columns:
subset(quakes, mag >= 7.3, select = c(location, date, mag))

# Same thing:
quakes[quakes$mag >= 7.3, c('location', 'date', 'mag'),
  drop = FALSE]

# Subsetting with subset() or [ gives you back
#   + multiple elements
#   + a data frame or list
# Extracting with $ or [[ gives you back
#   + one element
#   + a vector

# order() returns the permutation which sorts a vector.
#
#   order(DATA, decreasing = FALSE)
#
x = c(10, 30, 20, 40)
x
ordering = order(x, decreasing = TRUE)
ordering
x[ordering]
x

# Use order to sort a matrix or data frame by a set of
# columns.
num = sample(1:100, 6)
num
A = matrix(num, 3, 2)
A

# sort() doesn't do what we want:
sort(A)

# order() does:
ord = order(A[ , 1], decreasing = FALSE)
ord
A[ord, ]

# Sort a data frame or table.
ordering = order(quakes$mag, quakes$depth,
                 decreasing = TRUE)

head(quakes[ordering, c("mag", "depth")], 10)

# Several more functions are useful with data frames:
#   * rbind(), cbind()
#   * data.frame(), as.data.frame()

# Plotting Data
# =============

# Convert numerical data to categorical with cut()
quakes$depth_cat = cut(quakes$depth, 5)
cut(quakes$depth, c(-Inf, 0, Inf))

mag_by_depth = split(quakes$mag, quakes$depth_cat)
boxplot(mag_by_depth)

# Save default plot settings before changing anything.
settings = par()

# Get current margins.
par("mar")

# Goal: plot horizontally, with a tick for every magnitude.
par(mar = c(5.1, 6.1, 4.1, 2.1), xpd = FALSE)

boxplot(mag_by_depth, horizontal = TRUE, col = "thistle",
        las = 1, main = "Quake Mag by Depth",
        xlab = "Magnitude", xaxt = 'n')

# Add y-label farther from the plot.
title(ylab = "Depth", line = 5)

# Add axis.
axis(1, seq(0, 10, 1), pos = -0.37)

# Add a legend--this is only for demonstration, as this plot doesn't need one.
# Use xpd = NA to allow drawing outside the plot box.
par(xpd = NA)
legend(-1, 8, c("Hello", "Goodbye"),
       fill = c("tomato3", "wheat"), cex = 0.75)

# Use locator() to determine plot coordinates.
# The argument is the number of times you want to click.
locator(1)

# Restore old plot settings.
par(settings)

?boxplot
?par

# List the colors available.
colors()

# Also see the RColorBrewer package and www.colorbrewer2.org
install.packages("RColorBrewer")
?RColorBrewer

# Lattice
# =======
# Lattice is an R package for making high-quality plots,
# and is included with the R distribution.
#
# An R package contains additional code/functions that are
# not part of the core language. Installed packages can be
# loaded with the library() function. This must be done per
# session.

library(lattice)

# Some lattice plotting functions:
#   * xyplot()
#   * stripplot() -- one-dimensional scatterplot
#   * barchart()
#   * dotplot()
#
#   * bwplot()  -- box and whiskers plot (a box plot)
#   * densityplot()
#   * histogram()
#   * qqmath()  -- quantile-quantile plot
#
#   * splom()   -- matrix of scatterplots
#
# Often useful to read ?panel.PLOT as well.
?lattice

densityplot(~ mag, quakes)

# Group according to location.
densityplot(~ mag, quakes, groups = location)

# Add a legend and don't plot points.
densityplot(~ mag, quakes, groups = location,
            auto.key = TRUE, plot.points = FALSE)

# Use separate panels for each group.
densityplot(~ mag | location, quakes,
            auto.key = TRUE, plot.points = FALSE, main = "hi")

# Group both ways.
quakes$recent = quakes$year > 2004
key = list(space = 'right', title = 'After 2004?',
           text = c("No", "Yes"))
densityplot(~ mag | location, quakes, groups = recent,
       auto.key = key, plot.points = FALSE)

# Show the default settings.
show.settings()

# Change settings with these:
?trellis.par.set
?trellis.par.get

# ggplot2
# =======
# ggplot2 is another package for creating plots.
#
# See ggplot2.org for documentation.

install.packages('ggplot2')

library(ggplot2)

# Make simple plots with qplot().
qplot(quakes$mag, quakes$depth)

# Use the grammar of graphics for more complicated plots.
gg =
  ggplot(quakes, aes(x = mag)) +
  geom_density(aes(fill = location), alpha = 0.3)

gg

# Same plot we made using lattice:
gg =
  ggplot(quakes, aes(x = mag)) +
  geom_density(aes(colour = recent), alpha = 0.3) +
  guides(colour = guide_legend(title = 'After 2004?')) +
  facet_grid(. ~ location)
gg

# There are a lot of possibilities here. The basic idea is
#   PLOT = DATA + GEOMETRY + ...

# Aggregating Data
# ================

# lapply:
#   Apply a function to each element of a vector.
#
#   lapply(DATA, FUNCTION, ...)

x = c(1, 2, 3)
lapply(x, sin)

# Better to use vectorization, if the function is
# vectorized.
sin(x)

# Why (and how) does lapply() work on data frames?
lapply(quakes, typeof)

lapply(quakes[c("mag", "depth")], mean)

# sapply:
#   Apply a function to each element of a vector,
#   simplifying the result.
#
#   sapply(DATA, FUNCTION, ...)

sapply(quakes, typeof)

sapply(quakes[c("mag", "depth")], mean)

# Now for something completely different!

# split:
#   Split the rows of a data frame into groups,
#   according to one or more factors.
#
#   split(DATA, GROUPING)

by_location = split(quakes, quakes$location)
names(by_location)
lapply(by_location, head)

# tapply:
#   Split the rows of a data frame into groups, according to
#   one or more factors, and then apply a function to each
#   group.
#
#   Equivalent to split() followed by sapply().
#
#   tapply(DATA, GROUPING, FUNCTION)

mag_by_location = split(quakes$mag, quakes$location)
sapply(mag_by_location, mean)

tapply(quakes$mag, quakes$location, mean)
