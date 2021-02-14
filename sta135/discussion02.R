# Discussion2.R

# Office Hours:
# W 1-2pm
# Th 11-12:30pm
# MSB 1117

# ----- Data Class Rundown
# What is a class? It describes how R "sees" the 
# data.

# integer
class(5L)

# double/numeric
class(5)
class(5.5)

# complex
class(0 + 5i)

# character
class("hi")

# data.frame
load("humans.rda")
humans
class(humans)

# factor
class(humans$gender)
levels(humans$gender)

# Classes of variables will not play a major role
# in the things we do in this course, but having
# some familiarity with them can be useful for
# understanding error messages.

# ----- Data Manipulation

# To get the number of rows or columns in a
# data.frame:
nrow(humans)
ncol(humans)

# The split() function splits the data into groups
# according to some factor (or character). Its 
# format is
#   split(DATA, SPLIT)
# where DATA is the data you want to split, and 
# SPLIT is the values you want to use to split, 
# which need not be in DATA (but must have the 
# same number of rows).

split(humans, humans$type)
split(humans, c(1, 1, 1, 0, 0))

# The sapply() function applies another function 
# over each element of the data. Its format is
#   sapply(DATA, FUNCTION, ARGS)
# where DATA is the data to apply over, FUNCTION 
# is the function to apply, and ARGS are extra 
# arguments to FUNCTION.

splitted = split(humans$height, humans$gender)
splitted
sapply(splitted, mean)

# The tapply() function is a shortcut for doing a 
# split() followed by an sapply(). Its format is
#   tapply(DATA, SPLIT, FUNCTION, ARGS)
# where SPLIT is the splitting variable (or list 
# of them).
tapply(humans$height, humans$gender, mean)

tapply(humans$height, 
       list(humans$gender, humans$type), 
       mean)


# The aggregate() function is similar to tapply(),
# but returns the data in an easy-to-use 
# data.frame format.
aggregate(humans$height, 
          list(gender = humans$gender), mean)

aggregate(humans$height, 
          list(gender = humans$gender,
               type = humans$type),
          mean)

# ----- More Lattice
# Source: USDA organic fruit prices data
# http://www.ers.usda.gov/data-products/
#   organic-prices.aspx

load("fprices.rda")
head(fprices)

library(lattice)

# Let's make a plot comparing conventional prices
# against organic prices.
xyplot(price ~ date | type, fprices, 
       groups = fruit,type = 'l')

# We can add a legend by using the auto.key
# parameter, which is described in:
?xyplot
# See also the entry for "key" (within ?xyplot),
# and:
?simpleKey

# Here's the plot with the legend:
key = list()
xyplot(price ~ date | type, fprices, 
       groups = fruit, type = 'l',
       auto.key = key)

# More reading of ?simpleKey reveals how to make
# the legend show lines instead of points:
key = list(points = FALSE, lines = TRUE)
xyplot(price ~ date | type, fprices, 
       groups = fruit,type = 'l',
       auto.key = key, main = "Fruit Prices")

# Switching the order of the grouping might
# improve the plot, depending on the features
# of interest. If we are more interested in how
# organic / conventional prices compare than
# how fruit prices compare, we might prefer this
# grouping:
key = list(points = FALSE, lines = TRUE)
xyplot(price ~ date | fruit, fprices, 
       groups = type,type = 'l',
       auto.key = key, main = "Fruit Prices")

# Use price per pound instead of price:
key = list(points = FALSE, lines = TRUE)
xyplot(I(price / weight) ~ date | type, fprices, 
       groups = fruit,type = 'l',
       auto.key = key, main = "Fruit Prices")

fprices$priceper = with(fprices, price / weight)
fprices$priceper = fprices$price / fprices$weight

key = list(points = FALSE, lines = TRUE,
           columns = 2)
xyplot(priceper ~ date | type, fprices, 
       groups = fruit,type = 'l',
       auto.key = key, main = "Fruit Prices")

# Put legend on the right:
key = list(points = FALSE, lines = TRUE,
           space = "right", border = "black")
xyplot(priceper ~ date | type, fprices, 
       groups = fruit,type = 'l',
       auto.key = key, main = "Fruit Prices")

key = list(points = FALSE, lines = TRUE,
           space = "right", border = "black",
           title = "Fruit", cex.title = 1)
xyplot(priceper ~ date | type, fprices, 
       groups = fruit,type = 'l',
       auto.key = key, main = "Fruit Prices")

# It's easy to change the colors of the lines on
# the plot:
palette = c("#8AE234", "#EF2929")
key = list(points = FALSE, lines = TRUE,
           space = "right", border = "black",
           title = "Fruit", cex.title = 1)
xyplot(priceper ~ date | type, fprices, 
       groups = fruit,type = 'l',
       auto.key = key, main = "Fruit Prices",
       col = palette)
# However, the colors of the legend don't get
# changed.

# In order to fix the colors of the legend, we
# need to change the default lattice colors. We
# can see what these are visually:
show.settings()

# Alternatively, we can examine the text
# representation of them:
settings = trellis.par.get()
str(settings)

# Before changing any settings, it's a good idea
# to keep a copy of the defaults. In this case,
# the settings variable is a copy of the defaults.
# To restore the default settings, use:
trellis.par.set(settings)

# To actually change a setting, locate it in the
# visual or text representation, and then change
# it:
trellis.par.set(superpose.line = list(col = palette))

# Now the legend has the correct colors:
xyplot(priceper ~ date | type, fprices, 
       groups = fruit,type = 'l',
       auto.key = key, main = "Fruit Prices",
       col = palette)

# Add gray background:
trellis.par.set(panel.background = 
                    list(col = "gray95"))

xyplot(price ~ date | type, fprices, 
       groups = fruit,type = 'l',
       auto.key = key, main = "Fruit Prices",
       col = palette, ylab = "Price ($/lb)",
       xlab = "Date")

# Base R graphics functions such as points(),
# lines(), and abline() will not work with
# lattice. To add lines or points to a lattice
# plot, you need a custom panel function.

# The panel function tells lattice how to draw
# the plot. Each lattice plotting function
# (xyplot, densityplot, ...) has a corresponding
# panel function (e.g. panel.xyplot) that actually
# does the drawing. There are also panel functions
# corresponding to the base R graphics functions
# for adding lines and points (e.g. panel.lines).
# These can be used to add arbitrary lines or
# points to a lattice plot.

xyplot(priceper ~ date | type, fprices, 
       groups = fruit,type = 'l',
       auto.key = key, main = "Fruit Prices",
       col = palette,
       panel = function(x, y, ...) {
           # Make the xyplot.
           panel.xyplot(x, y, ...)
           # Make a horizontal line at y = 1.
           panel.abline(h = 1)
       })

# More details and examples in: 
?panel.lines
?panel.xyplot
