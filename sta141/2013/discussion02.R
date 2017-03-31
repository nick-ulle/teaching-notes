# discussion02.R

# ----- Announcements -----
# Office hours changed slightly:
# M 12:30-2pm
# W 2:30-4pm

# Today only:
# 1:10 - 2:10pm

# ----- Discussion -----

setwd('D:/STA141/Discussions/')
flights <- read.csv('data/FiveAirports.csv')

# Store code as R scripts, which have extension .R

# Writing clean, organized code is an essential programming skill.
#   - Use variable names that describe the contents.
#   - Use spaces around operators such as +, -, *, and /.
#   - Make comments with # to explain complex pieces of code.
#       - Also use comments to guide your design.
#   - Check out Google's R style guide.

5+5-6+3 # Don't write code like this line.

5 + 5 - 6 + 3 # Use spaces!

# This is comment, because it starts with #.

# Try to make your code legible for others, but more importantly,
# make it legible for *yourself* 6-12 months after writing.

# lapply: apply a function over elements.

# Construct an example data set.
my_data <- data.frame(code = rnorm(9),
                      distance = rnorm(9),
                      airport = rep(c('SFO', 'SMF', 'LAX'), each = 3)
                      )
my_data[1, 1] <- NA
my_data[3, 3] <- NA

# Take a look at it.
my_data

lapply(my_data, summary)
lapply(my_data[1:2], mean, na.rm = TRUE)

# sapply: apply a function over elements, simplifying the result.
sapply(my_data[1:2], mean)
sapply(my_data, summary)

my_data[1, 1] <- NA
sapply(my_data[1:2], mean, na.rm = TRUE)

# split: break data into groups.
#   - Factors are used to delineate the groups.
code_by_airport <- split(my_data$code, my_data$airport)
sapply(code_by_airport, mean, na.rm = TRUE)

split(my_data, my_data$airport)

a_matrix <- matrix(1:4, 2, 2)
a_matrix
sapply(a_matrix, mean)

# Split but treat NA as a category.
split(my_data, factor(my_data$airport, exclude = NULL))
# This is necessary because by default, factors exclude NA levels.

# Someone also asked if we could use the exclude parameter to exclude values
# other than NA. Yes, you can:
split(my_data,
      factor(as.character(my_data$airport), exclude = c('SMF', NA))
)
# Why do we have to do it this way? If you examine
class(my_data$airport)
# you see that it's already a factor. The exclude parameter expects a
# vector of the same class (a factor). Unfortunately, the exclude parameter
# has a bug and doesn't work when you pass it a factor. So, we first
# convert my_data$airport to a character vector, and then pass exclude a
# character vector as well.

# All of that being said, a clearer way to get the same result would be to
# use subset.

# In the 11-12 discussion we had some trouble with the following code:
flights_by_origin <- split(flights['DISTANCE'], flights['ORIGIN'])      
sapply(flights_by_origin, mean, na.rm = TRUE)
# The problem is that flights['DISTANCE'] is a data.frame
class(flights['DISTANCE'])
# so the split produces a list of data.frames. But the mean function doesn't
# know how to handle a data.frame:
mean(flights['DISTANCE'])
# By extension, applying the mean function to each data.frame in a list of
# data.frames doesn't work.
      
# Instead, we need to split the column as a vector, using either of the 
# following:
      
flights_by_origin <- split(flights$DISTANCE, flights$ORIGIN)

# tapply: apply a function over groups.
#   - Also see aggregate and by.
      
# This is the same as what we did with split and sapply above (line 52-53).
tapply(my_data$code, my_data$airport, mean, na.rm = TRUE)
      
# mapply: apply a function over several vectors/lists simultaneously.
      
# lattice: fancier plots.
library(lattice)
?lattice

x <- with(anscombe, c(x1, x2, x3, x4))
y <- with(anscombe, c(y1, y2, y3, y4))
anscombe_bound <- data.frame(x = x, y = y, Group =
  factor(rep(1:4, each = nrow(anscombe))) )

# Use the groups parameter to specify color-coding of points. Each color
# corresponds to one level of Group.
xyplot(y ~ x, anscombe_bound, groups = Group, auto.key = TRUE)

# Use | to specify grouping for side-by-side plots. Each plot corresponds to
# one level of Group.
xyplot(y ~ x | Group, anscombe_bound, type = 'p')

# You can also combine | and the groups parameter to make several plots
# corresponding to levels of one categorical variable, each having points
# colored according to another categorical variable.
      
# Lattice plotting functions such as xyplot will accept most of the same
# parameters as plot.
      
# The most powerful feature of lattice is that you can customize the plotting
# function by passing a function to the panel parameter. This should be a 
# function that takes x, y, and ... but don't worry too much about the details
# for now. We'll talk about the R function called function in a week or two.
xyplot(y ~ x | Group, anscombe_bound, col = 'black',
       panel = function(x, y, ...) {
         # Inside of the curly braces, x and y are the x and y points for
         # one group.
         
         # Make the xyplot.
         panel.xyplot(x, y, ...)
         # Make a line with intercept 3 and slope 0.5.
         panel.abline(a = 3, b = 0.5, col = 'blue')
         # Make a horizontal line at 7.5.
         panel.abline(h = 7.5, col = 'blue', lty = 'dashed')
         })
      
