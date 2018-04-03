# STA 141a
# ========
# TA: Nick Ulle
#     naulle@ucdavis.edu
#
# Office Hours:
#   Ben           M     2-4         MSB 1143
#   Nick          M     4-6         EPS 1317
#   Prof. Gupta   TR    1:30-3:30   MSB 4240
#   Jiahui        F     3:30-5:30   MSB 1143


# Infographic (sort of):
#
#   * Hacker News:
#       https://news.ycombinator.com/
#
#   * Data Tau:
#       https://www.datatau.com/

# do.call
# -------
x = list(c("A", "B", "C", "D"), 2, prob = c(0.1, 0.2, 0.3, 0.4))

sample(x[[1]], x[[2]], prob = x[[3]])

do.call(sample, x)

rnorm(1, 2, 3)
x = list(1, 2, 3)
sapply(x, rnorm)
rnorm(1)
rnorm(2)
rnorm(3)

do.call(rnorm, x)

# ggplot2
# -------
# The 3 main ways to make plots in R are:
#
# 1. base R - `plot()` and friends
#
# 2. lattice
#
# 3. ggplot2
#
# Each is incompatible with the others. For instance, base
# R plot commands don't affect with lattice plots.


# ggplot2's fundamental idea is that ANY graphic is
# composed of a few layers:
#
# Layer | Name        | Examples
# ----- | ----------  | --------
# data  | data        | any data frame
# aes   | aesthetics  | x and y position, color, line style
# geom  | geometry    | points, lines, bars, boxes
# stat  | statistics  | none, bins, sums, means
# scale | scales      | axes, legends
# coord | coordinates | Cartesian, logarithmic, polar
# facet | facets      | side-by-side panels
#
# These layers form a descriptive "grammar of graphics".
#
# See the documentation at:
#     http://ggplot2.tidyverse.org/reference/
#
# So how can we actually make a plot?

#install.packages("ggplot2")
library("ggplot2")

head(diamonds)

# The "q" in `qplot()` stands for "quick".
qplot(carat, price, data = diamonds)

# The `ggplot()` function gives you more control over the
# plot.

gg = ggplot(diamonds, aes(x = carat, y = price))
gg

# The `ggplot()` function just sets up the data and
# aesthetic layers. It's up to you to add geometries!
#
# Change the geometry to change the type of plot. It's
# possible to use multiple geometries.

gg + geom_point()
gg + geom_line()

# Easy to drop in a different data frame:

#df = subset(diamonds, price >= 10000)
gg = ggplot(diamonds, aes(x = carat, y = price, color = cut))
gg = gg + geom_point()
gg

gg %+% subset(diamonds, price >= 10000)
gg %+% subset(diamonds, cut == "Fair")
gg %+% subset(diamonds, depth > 65)

# Note that `%+%` does not work well with ggmap.

# To learn more about how to customize ggplots, read
#
# * "ggplot2" by Hadley Wickham
#
# * "The R Graphics Cookbook" by Winston Chang
#


# Now a real example in  `week5_example.R`!


# Categorization
# --------------
# You can convert numerical data to categories (binning)
# with `cut()`.
#
#     cut(x, breaks, labels, right)

samp = rnorm(5)
cut(samp, c(-Inf, 0, Inf), c("-", "+"))

