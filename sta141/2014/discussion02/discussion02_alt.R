
# Data
# ====

# View and change the working directory.
getwd()
setwd("D:/data")
dir()

# Load some data that's already in R's standard format.
# RDA stands for "R Data".
load('housing.rda')

# Now what? Check for new variables.
ls()

# Clean up the workspace by removing some variables.
rm(a, A, B, x, y)
ls()

# Get some basic information about the housing data.
nrow(housing)
ncol(housing)
dim(housing)

length(housing)

names(housing)
colnames(housing)

summary(housing)

# Peek at the housing data.
head(housing)
tail(housing)

# What about the type?
typeof(housing)

# The class of an object tells R how it should behave.
class(housing)

class(5)
class(TRUE)
class(c(sin, cos, tan))

# More Extraction
# ===============

# Pull out the 'city' column from the housing data frame.
# This works for partial matches.
housing$city
housing$cit
housing[['city']]

# Yet another way to do this.
with(housing, city)

# Subsetting
# ==========
# Take the subset of all houses built between 1980 and 1990.
modern.homes = subset(housing, 1980 < year & year < 1990)
nrow(modern.homes)
nrow(housing)

# A Few More Things
# =================

# To complete this course successfully, you must:
#   + Format code neatly (use spaces and keep lines short)
#   + Use descriptive names for variables and functions
#   + Use *concise* comments to explain code
# Charles can and will take points off for code that is
# unreadable. No one will have any sympathy for you, because
# this part (formatting) is really, really easy.

# BAD code looks like this:
    y=numeric(100)
    for(x in 1:100){y[x]=log(mean(d[sample(1:nrow(d),nrow(d),T),]))}

# GOOD code looks like this:
b = 100
n = nrow(data)
boot.stats = numeric(b)

for (i in 1:b) {
    # Resample data, then compute bootstrap statistic.
    boot.samp = data[sample(1:n, n, replace=TRUE), ]
    boot.stats[i] = log(mean(boot.samp))
}

# For some suggestions on how to format code, see Google's
# guide:
# [http://google-styleguide.googlecode.com/svn/trunk/Rguide.xml]
