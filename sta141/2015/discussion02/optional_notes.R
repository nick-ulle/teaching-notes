load('../data/quakes.rda')
ls()

head(quakes)

# Remove NAs. This isn't always the best strategy!
quakes = na.omit(quakes)

locations = c("JAPAN", "NORTHERN CALIFORNIA",
              "CENTRAL CALIFORNIA", "SOUTHERN CALIFORNIA")
quakes = subset(quakes, location %in% locations)
quakes$location = factor(quakes$location)
saveRDS(quakes, '../data/quakes_subset.rds')

# Classes
# =======
# One-dimensional subsetting extracts a single column.
head(housing[1])

# A data frame is just a list of columns!
typeof(quakes)

# However, two-dimensional subsetting works.
# The syntax is
#
#   DATA[ROWS, COLUMNS]

quakes[1, 2]

quakes[c(1, 3, 7), c('mag')]

# This doesn't work with just any list.
list2d = list(a = 1:3, b = 3:5)
list2d
list2d[1, 1]

# Why are data frames special?
# The class of an object tells R how it behaves.
class(quakes)

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
colnames(quakes)

unclass(head(quakes))
