# discussion05.R

# Week 4
# ------
 
# Check out <rweekly.org> for news about R!

# For print- and colorblind-safe colors, see <colorbrewer2.org>, along with the
# R packages `RColorBrewer` and `viridisLite`.


# ggplot2
# -------
# The "gg" stands for _grammar of graphics_.
#
# > ...the grammar tells us that a statistical graphic is a mapping from data
# > to aesthetic attributes (colour, shape, size) of geometric objects (points,
# > lines, bars).
# >
# > -- H. Wickham

library(tidyverse) # includes ggplot2

diamonds
?diamonds

# Each graphic has several layers:
#
# Layer  | Description
# -------|------------
#   data | The information you want to display, as a tidy data frame. Columns
#        | of the data get mapped to aesthetic attributes.
#        |
#  geoms | The geometry of the plot, such as points, lines, and bars.
#        |
# scales | The scales show how the data was mapped to aesthetic attributes, so
#        | that humans can read the graph. Axes and legends are scales.
#        |
#  stats | The statistical transformations required to create the plot. For
#        | example, histograms require binning. In some cases, it's clearer to
#        | apply transformations before plotting.
#        |
# facets | Facets are groups (subsets) of the data that should be displayed in
#        | individual plots, side-by-side.
#        |
# coords | The coordinates control how data is mapped to geometry. For example,
#        | a plot can use Cartesian (x, y) coordinates or polar coordinates.
#
# At minimum, three things are needed to make a plot:
#
# 1. A data frame passed to `ggplot()`
# 2. A geom added to the plot with `+`.
# 3. An aesthetic mapping passed to the geom through `aes()`.
#
# Add additional layers with `+`.

# ### Example
# Plot carat vs price.

# Aesthetics inside `aes()` are mapped to the data.
aes(x = carat, y = price)

ggplot(diamonds) + geom_point(aes(x = carat, y = price))

# Alternatively, to set a default aesthetic for all geoms:
ggplot(diamonds, aes(carat, price)) + geom_point()

# You can use variables to build up plots.
plt = ggplot(diamonds, aes(carat, price))
plt = plt + geom_point()
plt

# To set a fixed value for an aesthetic, do so outside of `aes()`.
plt = ggplot(diamonds, aes(carat, price))
plt = plt + geom_point(color = "green")
plt

# Trying to set a fixed value for an aesthetic inside of `aes()` will give
# results you might not expect:
plt = ggplot(diamonds, aes(carat, price))
plt = plt + geom_point(aes(color = "green"))
plt

# To set a data-driven value for an aesthetic, do so inside of `aes()`.
plt = ggplot(diamonds, aes(carat, price, color = cut))
plt = plt + geom_point()
plt

# What's wrong with the plot above?
#
# * Lots of points plotted on top of each other (overplotting)
# * No units on the axes
# * No title
# * Colors aren't print- and colorblind-safe (change the point shapes to make
#   groups visually distinct)

plt = ggplot(diamonds, aes(carat, price, color = cut, shape = cut))
plt = plt + geom_point()
plt = plt + labs(title = "Diamond Prices", x = "Weight (carats)",
  y = "Price (USD)")
plt

# Use a faceted 2d density plot to address overplotting:
plt = ggplot(diamonds, aes(carat, price))
# The ..level.. variable is created by stat_density2d()
plt = plt + stat_density2d(aes(fill = ..level..), geom = "polygon")
plt = plt + labs(title = "Diamond Prices", x = "Weight (carats)",
  y = "Price (USD)")
plt = plt + facet_grid(cut ~ .)
plt


# ### Example
# Fit regression lines...
plt = ggplot(diamonds, aes(log(carat), log(price)))
plt = plt + geom_density2d()
plt = plt + labs(title = "Diamond Prices", x = "Weight (carats)",
  y = "Price (USD)")
plt = plt + facet_grid(cut ~ .)
plt = plt + geom_smooth(method = "lm", color = "black")
plt


# Use lm() if you want the statistics for the linear model.
model = lm(price ~ carat, diamonds)
summary(model)

# To fit a model for every group, use split and lapply:
by_cut = split(diamonds, diamonds$cut)

models = lapply(by_cut, function(grp) {
  lm(price ~ carat, grp)
})


# What else can ggplot2 do?
#
# See <r4ds.had.co.nz/data-visualisation.html> for an introduction.
#
# See <docs.ggplot2.org> for a complete list of geoms.


# dplyr
# -----
# The dplyr package is designed to make it easier to do analysis on tabular
# data (tidy data frames). Common analysis tasks are described with verbs:
#
# dplyr     | Description                | base R
# --------- | -------------------------- | ------
# filter    | Take a subset of rows      | [ or subset()
# arrange   | Sort rows                  | [ with order()
# select    | Take a subset of columns   | [, [[, or $
# mutate    | Create new columns         | [, [[, or $
# summarize | Compute summary statistics | aggregate()
# group_by  | Group based on a column    | split()
#
# Note: you can do all of these things without dplyr.

library(tidyverse) # includes dplyr


# ### Example
# Do carnivores sleep more than other animals?
#
# Or: is diet related to sleep in animals?

msleep
?msleep

# Get statistics about sleep, by diet.
grp = group_by(msleep, vore)
sleep = summarize(grp, mean = mean(sleep_total), sd = sd(sleep_total))
arrange(sleep, mean)

# Make a plot of sleep distributions, by diet.
plt = ggplot(msleep, aes(vore, sleep_total))
plt = plt + geom_boxplot(aes(fill = vore))
plt = plt + scale_fill_hue(guide = FALSE)
plt = plt + labs(title = "Animal Sleep Distributions")
plt = plt + geom_point(stat = "summary", fun.y = mean, shape = 8)

# `geom_line()` tries to connect points in the same group.
plt = plt + geom_line(aes(group = 1), stat = "summary", fun.y = mean)

# Also see <r4ds.had.co.nz/transform.html>.


# broom & tidyr
# -------------
# Data contains measurements amount one or more subjects.
#
# An _observation_ is all of the measurements taken for one subject.
#
# A _covariate_ is one measurement taken across all of the subjects.
#
# Tidy data follows two rules:
#
# 1. Each observation has its own row.
# 2. Each variable has its own column.
#
# Most of the tidyverse packages, including dplyr and ggplot2, are designed to
# work with tidy data.


# The broom package has tools to automatically convert base R function output
# to tidy data.
#
# See <github.com/dgrtwo/broom>.


# The tidyr package has tools to manually convert tabular data to tidy data.
#
# See <r4ds.had.co.nz/tidy-data.html>.
