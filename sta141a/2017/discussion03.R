# STA 141a
# ========
# TA: Nick Ulle
#     naulle@ucdavis.edu
#
# Office Hours:
#   Ben           M     2-4         MSB 1143
#   Nick          M     4-6         EPS 1317
#   Prof. Gupta   TR    1:30-3:30   MSB 4240
#   Jiahui        W     10-12       Academic Surge 2142


# Infographic:
#   http://graphics.latimes.com/kobe-every-shot-ever/

# Reminders:
#
# * Assignment 2 is more difficult, so get started early.

 
dogs = readRDS("data/dogs/dogs_full.rds")

# Apply Functions
# ---------------
#
# lapply:
#   Apply a function to each element of a vector.
#
#   lapply(DATA, FUNCTION, ...)

x = c(3, 7, 9)

# Better to use vectorization, if the function is
# vectorized.

# BAD:
lapply(x, sqrt)

# GOOD:
sqrt(x)

# So what's an example of a non-vectorized function?

class(dogs)
typeof(dogs)
# Data frames are lists (of columns)!
unclass(dogs)

dogs["weight"]

cls = lapply(dogs, class)

cls
class(cls)


# sapply:
#   Apply a function to each element of a vector,
#   simplifying the result.
#
#   sapply(DATA, FUNCTION, ...)

cls2 = sapply(dogs, class)

cls2
class(cls2)

# Now for a detour...
# split:
#   Split the rows of a data frame into groups,
#   according to one or more factors.
#
#   split(DATA, GROUPING)

by_kids = split(dogs$weight, dogs$kids)
by_kids

names(by_kids)

split(dogs[c("weight", "height")], dogs$kids)

# A common pattern is split-sapply.
by_kids = split(dogs$weight, dogs$kids)
sapply(by_kids, mean, na.rm = T)

# tapply:
#   Split the rows of a data frame into groups, according
#   to one or more factors, and then apply a function to
#   each group.
#
#   Equivalent to split() followed by sapply().
#
#   tapply(DATA, GROUPING, FUNCTION)
tapply(dogs$weight, dogs$kids, mean, na.rm = T)

table(dogs$category, dogs$kids)

# aggregate:
#   Similar to tapply(), but output is a data.frame.

df = aggregate(weight ~ kids, dogs, mean)
class(df)

# More than one categorical variable:
aggregate(weight ~ kids + category, dogs, mean)



# Dates
# -----
#
# Use `as.Date()` to convert a string to a date.
x = c("October 31, 2017", "November 14, 2012")
class(x)

as.Date(x, "%B %d, %Y")

typeof(as.Date("2017-01-03"))

# Date format codes for both are described in ?strptime.
?strptime

# NOTE: Any format code that mentions the 'current locale'
# in its description means your computer's default
# language.
#
# For example,
#
#   ‘%B’ Full month name in the current locale.
#
# On a computer where the default language is Simplified
# Chinese, then `%B` will match
#
#   一月 or 二月 or 三月 or ...
#
# rather than
#
#   January or February or March or ...
#
# You can check the language settings on your computer
# with:
Sys.getlocale()

# You may need to change R or your computer's language
# settings if you want to use a format code that mentions
# 'current locale'.
#
# See:
#  https://stackoverflow.com/questions/16347731/how-to-change-the-locale-of-r-in-rstudio


# Use `strptime()` to convert a string to a time.
"Oct 31, 2017 5:15pm"


# Statistical Models
# ------------------
# "All models are wrong, but some are useful." -- G. Box

plot(weight ~ height, dogs)
model = lm(weight ~ height, dogs)
summary(model)
plot(model)

# The residuals are the differences between the true values
# and the line.
#
# Residuals measure error, so minimize residuals! How?
#
# What if we choose the line that has the smallest squared
# residuals? This is "least squares," the most popular
# strategy!
#
# The sum of the squared residuals emphasizes large errors.
# This is more conservative than the sum of their absolute
# values.
#
# The best way to measure error really depends on the
# problem!


# Conditions for linear models:
#
# 1. Linearity! The data should follow a straight line. If
#    there is any other pattern (such as a parabola) a
#    linear model is not appropriate.
#
# 2. Independent observations. The observations should not
#    depend on each other. As an example, a time series
#    would violate this condition.
#
# 3. Constant variance. Observations should be roughly the
#    same distance from the line across all values of the
#    predictor variable x.
#
# 4. Gaussian residuals. In order to construct confidence
#    intervals for or test the model, the residuals must
#    have a Gaussian (normal) distribution.
#
# Conditions 1, 3, and 4 can be checked with residual
# plot(s). Condition 4 can also be checked with a
# quantile-quantile (Q-Q) plot.
#
# For condition 2, think carefully about whether it makes
# sense for your data that the observations would be
# indpendent.
#
#
#
# For more details, see chapters 5-6 from:
#   https://www.openintro.org/stat/textbook.php?stat_book=isrs
#
# For interpreting diagnostic plots, see:
#   http://data.library.virginia.edu/diagnostic-plots/
