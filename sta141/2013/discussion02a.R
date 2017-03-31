# Discussion2.R

# ----- Announcements -----
# Office hours changed slightly:
# M 12:30-2pm
# W 2:30-4pm

# Unofficial office hours this week:
# F 1:10-2:10pm

# MSB 1147

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

# This is a comment!

# I'm going to compute the mean.

# Try to make your code legible for others, but more importantly,
# make it legible for *yourself* 6-12 months after writing.

# lapply: apply a function over a list.
class(flights)
lapply(flights[c('DISTANCE', 'ORIGIN')], summary)

a <- 1:5
lapply(a, mean)

# Convert to data.fram
as.data.frame(my_matrix)


# sapply: apply a function over a list, simplifying the result.
sapply(a, mean)

lapply(flights[c('DISTANCE', 'DEP_DELAY')], mean, na.rm = TRUE)
sapply(flights[c('DISTANCE', 'DEP_DELAY')], mean, na.rm = TRUE)

# split: break data into groups.
#   - Factors are used to delineate the groups.
flights_by_origin <- split(flights['DISTANCE'], flights['ORIGIN'])
flights_by_origin <- split(flights$DISTANCE, flights$ORIGIN)

sapply(flights_by_origin, mean, na.rm = TRUE)
lapply(flights_by_origin, mean, na.rm = TRUE)

a <- data.frame(dist = rnorm(3), origin = c('LAX', 'SFO', 'SFO'))


# tapply: apply a function over groups.
#   - Also see aggregate and by.
tapply(a$dist, a$origin, mean)

# mapply: apply a function over several lists simultaneously.


# lattice: fancier plots.
library(lattice)
?lattice

x <- with(anscombe, c(x1, x2, x3, x4))
y <- with(anscombe, c(y1, y2, y3, y4))
anscombe_bound <- data.frame(x = x, y = y, Group =
  factor(rep(1:4, each = nrow(anscombe))) )

xyplot(x ~ y, anscombe_bound, groups = Group, auto.key = TRUE)

xyplot(y ~ x | Group, anscombe_bound, type = 'p')

xyplot(y ~ x | Group, anscombe_bound, col = 'black',
       panel = function(x, y, ...) {
         panel.xyplot(x, y, ...)
         panel.abline(a = 3, b = 0.5, col = 'blue')
         panel.abline(h = 7.5, col = 'blue', lty = 'dashed')
       })