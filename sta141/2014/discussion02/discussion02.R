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
# Writing clean, organized code is an essential programming
# skill.
#   * Use variable names that describe the contents.
#   * Use spaces around operators such as +, -, *, and /.
#   * Make comments with # to explain complex pieces of code.
#       - Also use comments to guide your design.
#   * Check out Google's R style guide.
#
# Charles can and will take points off for code that's
# unreadable.

# BAD code looks like this:
hist(na.omit(subset(iris$Sepal.Length,iris$Species=='setosa'))[1:25],col=c(1,2,3,4,5))

y=numeric(100)
# Loop
for(x in 1:100){y[x]=log(mean(d[sample(1:nrow(d),nrow(d),T),]))}
# -----

# GOOD code looks like this:
setosa = subset(iris$Sepal.Length, iris$Species == 'setosa')
setosa = na.omit(setosa)
hist(setosa[1:25], col=1:5, main='Setosa Histogram',
     xlab='Sepal Length')

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

head(housing)

# One-dimensional subsetting extracts a single column.
head(housing[1])

# A data frame is just a list of columns!
typeof(housing)

# However, two-dimensional subsetting also works.
# The syntax is
#
#   DATA[ROWS, COLUMNS]

housing[1, 2]

housing[c(1, 3, 7), c('price')]

# This doesn't work with just any list.
list2d = list(a = 1:3, b = 3:5)
list2d
list2d[1, 1]

# Why are data frames special?
# The class of an object tells R how it behaves.
class(housing)

class(sin)

class(1:3)

class(c(1, 2, 3))

class(list2d)

# type: what is it?
# class: how does it behave?
#
# An object has exactly one type, but may have several
# classes.

# Removing the class reveals the underlying list structure.
colnames(housing)

unclass(head(housing))

# Take a sample.
n = nrow(housing)
n

cols = c('county', 'price', 'br', 'lsqft', 'bsqft', 'date')
indexes = sample(1:n, 100)
indexes

samp = housing[indexes, cols]
head(samp)
nrow(samp)

# What if we wanted it to be reproducible?
# The set.seed() function has the syntax
#   set.seed(SEED)
# where SEED is the number used to generate the pseudorandom
# number sequence.
set.seed(5)
sample(1:100, 3)

# Same samples.
set.seed(5)
sample(1:100, 3)

# Different samples.
set.seed(5)
sample(1:100, 3)

# ONLY SET THE SEED ONCE, AT THE BEGINNING OF YOUR CODE!

head(samp)

# What if we wanted to number the rows 1 to 100?
rownames(samp) = NULL
head(samp)

# Can also use custom row names. These have to be unique.
rownames(samp) = c('row1', 'row2', 'row3', ...)

# The subset function is another way to take a subset. The
# syntax is
#
#   subset(DATA, CONDITION, select = COLUMNS)
subset(samp, br == 5, select = price)

# Same thing:
samp[samp$br == 5, c('price'), drop = FALSE]

# Here's what the condition looks like:
samp$br == 5

# Select specific columns.
subset(samp, br == 5, select = c(county, br))

# Same thing:
samp[samp$br == 5, c('county', 'br')]

# order() is useful for more than just data frames, but...
# order:
#   Returns the permutation which sorts a vector.
#
#   order(DATA, decreasing = FALSE)

x = c(10, 30, 20, 40)
ordering = order(x, decreasing = TRUE)
ordering
x[ordering]
x

sort(x)

sort(samp)

# Sort a matrix
num = sample(1:100, 6)
num
A = matrix(num, 2, 3)
A
sort(A)
ord = order(A[ , 1], decreasing = FALSE)
A[ord, ]

# Sort a data frame or table.
br.ord = order(samp$br, samp$lsqft, decreasing = TRUE)
head(samp[br.ord, ])

# Several more functions are useful with data frames:
#   * nrow(), ncol(), dim()
#   * rownames(), colnames(), names()
#   * rbind(), cbind()
#   * data.frame(), as.data.frame()

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
splitted = split(samp, samp$county)
splitted

split(samp, samp$br)

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

price.by.br = split(samp$price, samp$br)
price.by.br = price.by.br[-6]
boxplot(price.by.br)

boxplot(price.by.br, main = 'Pricing Distributions',
        xlab = 'Price', ylab = 'Bedrooms',
        horizontal = TRUE, col = 'thistle',
        xaxt = 'n')
?boxplot
?par

seq(1, 20, 7)
axis(1, at = seq(0, 4e6, 5e5))

pdf('plot.pdf')
boxplot(price.by.br, main = 'Pricing Distributions',
        xlab = 'Price', ylab = 'Bedrooms',
        horizontal = TRUE, col = 'thistle',
        xaxt = 'n')
axis(1, at = seq(0, 4e6, 5e5))
dev.off()

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




