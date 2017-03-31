# discussion01.R

# STA 141
# =======
# Nick Ulle
# naulle@ucdavis.edu
# (use Piazza for R questions!)

# Make sure you can get into Piazza!
# Access code: sta141

# Office Hours:
#   * M 4-6pm, Earth Sci 1316, Nick
#   * T/Th ???, ???, Duncan
#   * F 9-11am, Math Sci 1147, Michael

# Stop by and introduce yourself!


# # Getting Started
# ===============
# Download and install:
#   + R [www.r-project.org]
#   + RStudio [www.rstudio.com] (optional)

# Your code shows your work!

# One way to store code is in an "R script", which
# is a text file whose name ends with ".R".

# If you need help with how to create a blank R
# script, see me, Michael, or Duncan ASAP.

# Getting Help
# ============

# THE SINGLE MOST IMPORTANT COMMAND IN R:
?load
?sin

??"number of rows"

# Also: Piazza, StackOverflow, and Google.


# Loading Data
# ============

# Load RDA files with load().
load("quakes.rda")

# R looks for files in the "working directory."
getwd()
start_dir = getwd()

# Change the working directory with setwd().
# In a file path, `..` means the directory above.
# Use / instead of \ on Windows.
setwd("../data/")
load("quakes.rda")
setwd(start_dir)

# Better to avoid changing the working directory:
load("../data/quakes.rda")

# Is the data loaded?
ls()


# Examining Data
# ==============

# Q: How big is it?
nrow(quakes)
ncol(quakes)
dim(quakes)

length(quakes)

# Q: What does it look like?
head(quakes)

# The second argument to head() controls the
# number of rows displayed.
head(quakes, 2)

tail(quakes)

summary(quakes)

# Q: What are the columns called?
colnames(quakes)
rownames(quakes)

names(quakes)

# Want to be a pro?
# Don't make assumptions about your data.
# Use the functions above to check instead.


# Extracting Columns
# ==================

# Use `$` to extract columns, without quotes.
quakes$mag
quakes$"mag"

# Use `[[` to extract columns, with quotes.
quakes[["mag"]]

# Why quotes?
# The `[[` operator expects a string argument.

# Why are there two ways to extract?
# The `[[` operator works with variables:
my_column = "lat"
quakes[[my_column]]
# The `$` operator saves typing when working
# interactively.

length(quakes$mag)
nrow(quakes$mag)
dim(quakes$mag)

# Which years have the most quakes?
table(quakes$year)

# Q: What kind of data is it?
typeof(quakes$mag)

# There are a few different "atomic" data types.
# The "double" type stands for double precision
# floating point. Think of it as real number.
typeof(8L)
typeof(8)
typeof(-3.1)
typeof(0+5i)
typeof(TRUE)

typeof(quakes)

# There are two types for functions.
typeof(typeof)
typeof(sin)

# Vector Math
# ===========

# Math operations work element-by-element on
# entire vectors. This is called vectorization.
head(quakes$mag)
head(2 * quakes$mag)

# You can combine vectors with c().
x = c(0, 1)
y = c(2, 3)

c(y, x, 7)

# Values get recycled.
head(x * quakes$mag)

# Many functions are vectorized, too.
sine_mag = sin(quakes$mag)
head(quakes$mag)
head(sine_mag)


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
#   * par()     -- change plot settings

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
#       plot(density(...))
#   * mosaicplot()
#
#   * pairs()       -- matrix of scatterplots
#   * matplot()     -- grouped scatterplot
#   * smoothScatter()

# Goal: show quakes by year in a plot.
plot(table(quakes$year))
plot(table(quakes$year),
     main = "Earthquakes by Year",
     xlab = "Year", ylab = "# of quakes")

# Goal: plot quake magnitudes for 3 regions.
regions = c("JAPAN", "CALIFORNIA", "KOREA")

# Use subset() to take a subset of the data.
my_quakes =
  subset(quakes, location %in% regions)

nrow(quakes)
nrow(my_quakes)

# Use split() to split the data into groups.
split_quakes =
  split(my_quakes, my_quakes$location)

length(split_quakes)
names(split_quakes)

?split

# Use `drop` to have split() drop empty groups.
split_quakes =
  split(my_quakes$mag, my_quakes$location,
        drop = TRUE)

length(split_quakes)

# Now we can plot.
boxplot(split_quakes)

# Make sure your plots have labels!
boxplot(split_quakes, ylab = "Magnitude",
        main = "Earthquake Magnitudes")
