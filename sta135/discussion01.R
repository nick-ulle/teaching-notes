# Discussion1.R

# STA 135
# =======
# TA: Nick Ulle <naulle@ucdavis.edu>
# Office Hours: see post on Piazza

# Computing
# =========

# ...

# Getting Started With R
# ======================
# Get help with ? or ??. The first does dictionary-style
# lookup, while the second does a search.

?load

?"+"

??"load"

# Make comments by starting a line with #. Use these to
# explain your code!

# Load data into R using these functions:
#   * load()        -- for R Data (RDA) files
#   * read.table()  -- for space or tab-separated files
#   * read.csv()    -- for comma-separated files

# To use the load() function, specify the path to the
# file, in quotes. The path can be relative to the current
# working directory, or an absolute path. A variable will 
# automatically be created.

# Show current working directory with getwd(). It can be
# changed with setwd(). On all operating systems, use /
# the directory separator.
getwd()
setwd("D:/path/to/directory/")

# Load the file.
load('data/quakes.rda')

# The ls() function lists all variables.
ls()

# Using Data
# ==========
# The head(), tail(), and summary() functions are useful
# for getting an idea of the shape of the data.

head(quakes)
tail(quakes)
summary(quakes)

names(quakes)
colnames(quakes)

# The simplest way to subset data is with the subset()
# function. Its form is
#   subset(DATA, CONDITION)
# where
#   DATA is the data to take the subset from
#   CONDITION is a TRUE/FALSE condition indicating which
#       rows to keep.

# Get all quakes with magnitude >= 9.
my_subset = subset(quakes, mag >= 9 | depth == 30)

# A column of data can be extracted (or inserted) with the
# column operator $.

# Get the "mag" column of quakes.
magnitude = quakes$mag

# Add a new column called "my_col" to the quakes variable.
quakes$my_col = 42

# Subsets of data can also be taken with the subset 
# operator []. There are two ways to do this:
#   1. Using row, column coordinates or names (leave blank 
#   to take all rows or all columns).

# Element at (1, 1).
quakes[1, 1] 

# Elements in row 2, over all columns.
quakes[2, ]

# Elements over all rows, in column 2.
quakes[, 2]

#   2. Using TRUE/FALSE values, with TRUE corresponding to
#   rows/elements to keep. This is similar to how subset()
#   works, but subset() is typically easier to use.

# Simple Plots
# ============
# Simple plotting functions:
#   * plot()    -- general purpose plot function
#   * lines()   -- add arbitrary lines to a plot
#   * points()  -- add points to a plot
#   * abline()  -- add straight lines to a plot
#   * legend()  -- add legends to a plot
#   * par()     -- change plot parameters (settings)

# Open a new plotting window.
x11()

# Plot magnitude (y) vs depth (x).
par(mar = c())

plot(quakes$depth, quakes$mag)

abline(h = mean(quakes$mag, na.rm = TRUE), col = "red")

# Plot latitude (y) vs longitude (x).
plot(lat ~ long, quakes)

# Recreate the magnitude/depth plot with better labels,
# smaller points, and colors.
plot(mag ~ depth, quakes,
     xlab = "Depth", ylab = "Magnitude", 
     main = "Magnitude vs Depth",
     cex = 0.5, col = "#FF0000")

# More plotting functions:
#   * barplot()
#   * dotchart()    -- use instead of a pie chart
#
#   * boxplot()
#   * stripchart()  -- one-dimensional scatterplot
#   * hist()
#   * density()     -- use with plot()
#   * mosaicplot()
#
#   * matplot()     -- grouped scatterplot function
#   * smoothScatter()

x11()

# Make a density plot of magnitudes.
plot(density(quakes$mag, na.rm = TRUE))

# Lattice
# =======
# An R package contains additional code/functions that are
# not part of the core language. Installed packages can be
# loaded with the library() function. This must be done per
# session.

# Lattice is an R package for making high-quality plots,
# and it's included with the R distribution.

library("lattice")

# A list of lattice plotting functions is given in ?lattice.

x11()

# The cut() function can convert numeric values into
# categories.
quakes$depth_catg = cut(quakes$depth, 4)

# Density plot of magnitudes, grouped by depth.
densityplot(~ mag | depth_catg, quakes, plot.points = FALSE,
            xlab = 'Magnitude', 
            main = 'Magnitude Density Plots, By Depth')

densityplot(~ mag, quakes, groups = depth_catg, 
            plot.points = FALSE, 
            auto.key = list(columns = 2),
            xlab = 'Magnitude', 
            main = 'Magnitude Density Plots, By Depth')

# Density plot of magnitude versus depth, grouped by day of
# week and subgrouped by depth.
quakes$wday = factor(quakes$wday, 
                     labels = c("Sun", "Mon", "Tue", "Wed",
                                "Thu", "Fri", "Sat"))
densityplot(~ mag | wday, quakes, groups = depth_catg,
            plot.points = FALSE, 
            auto.key = list(columns = 2),
            xlab = 'Magnitude', 
            main = 'Magnitude Density Plots, By Weekday & Depth')

# ggplot2
# =======
# ggplot2 is another package for making plots, but is not
# installed by default. To install a package from CRAN, the
# package repository, use install.packages(). You only need
# to do this once.

install.packages("ggplot2")

library("ggplot2")

# maps
# ====
# The maps package supports plotting maps.

install.packages("maps")

library("maps")

x11()
map()
big_quakes = subset(quakes, mag >= 8)
points(lat ~ long, big_quakes, col = "red", pch = 8,
       cex = 1.25)

# Make a gradient map.
ramp = colorRampPalette(c("white", "orange"))
smoothScatter(quakes$long, quakes$lat, bandwidth = 2,
              colramp = ramp,
              xlab = "Longitude", ylab = "Latitude",
              main = "Earthquake Danger Zones")
map(add = TRUE)
