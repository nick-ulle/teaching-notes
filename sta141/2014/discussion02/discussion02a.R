# discussion02.R

# Office Hours
# ============
# Come to office hours. It will make your life so much
# easier.
#
# Charles:  MWF 8 - 9am     MSB 1117
# Nick:     M   4 - 5:30pm  EPS 1316
#           W   1 - 2:30pm  MSB 4208
# Duncan:   T/R ???         MSB 4210

# Code Style
# ==========
# Writing clean, organized code is an essential programming skill.
#   * Use variable names that describe the contents.
#   * Use spaces around operators such as +, -, *, and /.
#   * Make comments with # to explain complex pieces of code.
#       - Also use comments to guide your design.
#   * Check out Google's R style guide.
#
# Charles can and will take points off for code that's
# unreadable.

# BAD code looks like this:
y=numeric(100)
# Loop
for(x in 1:100){y[x]=log(mean(d[sample(1:nrow(d),nrow(d),T),]))}
# -----

# GOOD code looks like this:
b = 100
n = nrow(data)
boot.stats = numeric(b)

for (i in 1:b) {
    # Resample data, then compute bootstrap statistic.
    boot.samp = data[sample(1:n, n, replace=TRUE), ]
    boot.stats[i] = log(mean(boot.samp))
}
# -----

# Data Frames
# ===========
setwd('D:/Projects/Teaching/2014.09 sta141/Discussion1')
load('housing.rda')
ls()

# A data frame is just a list of columns.
typeof(housing)

head(housing)

# Since a data frame is a list of columns, extracting an
# element in one dimension extracts a single column.
head(housing[1])

# Two-dimensional extraction also works, in which case the
# data frame behaves like a matrix.
data[1, 1]

# Take a sample.
n = nrow(housing)
n

cols = c('county', 'price', 'br', 'lsqft', 'bsqft', 'date')
indexes = sample(1:n, 100)
indexes

samp = housing[indexes, cols]
samp

rownames(samp) = NULL
samp

# There are two ways to take subsets.
samp[samp$br == 5, ]

subset(samp, br == 5)

# How does R know to give data frames special treatment?
# The class of an object tells R how it behaves. An object
# may have more than one class.
class(housing)
class(samp)

# Removing the class reveals the underlying list structure.
unclass(samp)

# It's useful for more than just data frames, but...
# order:
#   Returns the permutation which sorts a vector.
#
#   order(DATA, decreasing = FALSE)

x = c(1, 3, 2, 4)
ordering = order(x, decreasing = TRUE)
x[ordering]

# This is most useful for sorting a data frame or table.
lsqft.ord = order(samp$lsqft)
samp[lsqft.ord, ]

# Several more functions are useful with data frames:
#   * nrow(), ncol(), dim()
#   * rownames(), colnames(), names()

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

# LISTS ARE VECTORS!!!

samp
lapply(samp, typeof)

lapply(samp[3:5], mean, na.rm = TRUE)

# sapply:
#   Apply a function to each element of a vector,
#   simplifying the result.
#
#   sapply(DATA, FUNCTION, ...)

sapply(samp, typeof)

sapply(samp[3:5], mean, na.rm = TRUE)

# Now for a detour...
# split:
#   Split the rows of a data frame into groups,
#   according to one or more factors.
#
#   split(DATA, GROUPING)

samp
split(samp, samp$county)

split(samp, samp$county, drop = TRUE)

split(samp, list(samp$county, samp$br), drop = TRUE)

# tapply:
#   Split the rows of a data frame into groups, according to
#   one or more factors, and then apply a function to each
#   group.
#
#   Equivalent to split() followed by sapply().
#
#   tapply(DATA, GROUPING, FUNCTION)

counties = split(samp$br, samp$county)
sapply(counties, mean)

tapply(samp$br, samp$county, mean)

tapply(samp$price, list(samp$county, samp$br), mean)

# Plotting Data
# =============
# Simple plotting functions:
#   * plot()    -- general purpose plot function
#   * lines()   -- add arbitrary lines to a plot
#   * points()  -- add points to a plot
#   * abline()  -- add straight lines to a plot
#   * legend()  -- add legends to a plot
#   * axis()    -- add axes to a plot
#
#   * par()     -- change plot parameters (settings)

# There's a ton of info in ?par
?par

# More built-in plotting functions:
#   * barplot()
#   * dotchart()    -- use instead of a pie chart
#
#   * boxplot()
#   * stripchart()  -- one-dimensional scatterplot
#   * hist()
#   * density()     -- use with plot()
#   * mosaicplot()
#
#   * pairs()       -- matrix of scatterplots
#   * matplot()     -- grouped scatterplot
#   * smoothScatter()

price.by.county = split(samp$price, samp$br)
boxplot(price.by.county)

boxplot(price.by.county, main = 'Pricing Distributions',
        xlab = 'Price', ylab = 'Bedrooms',
        horizontal = TRUE, col = 'thistle',
        xaxt = 'n')
axis(1, at = seq(0, 4e6, 5e5))

# List the colors available. Also see the RColorBrewer
# package.
colors()

# Add a line to the plot at 500,000.
abline(v=5e5, lty = 'dashed')

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

xyplot(price ~ lsqft, samp)
?xyplot

xyplot(price ~ lsqft, samp, groups = county)

# Add a legend.
key = list(space = 'right')
xyplot(price ~ lsqft, samp, groups = county,
       auto.key = key)

# Split groups into many plots instead.
xyplot(price ~ lsqft | county, samp)

# Group both ways.
xyplot(price ~ lsqft | county, samp, groups = br,
       auto.key = key)


# Show the price distribution by number of bedrooms.
densityplot(~ price, samp, groups = br, auto.key = TRUE,
            plot.points = FALSE)

# Show the default settings.
show.settings()

# ggplot2
# =======
# ggplot2 is another package for creating plots. See
# ggplot2.org for documentation and tutorials.

install.packages('ggplot2')

library(ggplot2)

# Make simple plots with qplot().
qplot(samp$lsqft, samp$price)

qplot(samp$lsqft, samp$price, geom = c('point', 'smooth'),
      method = lm)

# Use the grammar of graphics for more complicated plots.
d = ggplot(samp, aes(x=lsqft, y=price))
d = d + geom_point(aes(color=county))
d = d + theme_classic()

# There are a lot of possibilities here. The basic idea is
#   PLOT = DATA + GEOMETRY + ...




