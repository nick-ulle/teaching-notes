# discussion06b.R

# Week 5
# ------


# Linear Models
# -------------
# "All models are wrong, but some are useful." -- G. Box

library(tidyverse)

# ### Example: Elmhurst College 2011 Financial Aid
# The Elmhurst data set has three variables.
#
# * family_income: total family income
# *      gift_aid: total gift aid for freshman year
# *    price_paid: total price paid for first year
#
# All values are in thousands of US dollars.

elm = read_tsv("data/elmhurst.txt")

# Is there a relationship between family income and gift aid?

plt = ggplot(elm, aes(family_income, gift_aid)) + geom_point()

# There's a trend, perhaps linear.
#
# y = (slope * x) + intercept
# y = (-5/50 * x) + 33

plt = plt + geom_abline(intercept = 33, slope = -5/50)

# The _residuals_ are the differences between the true values and the line.
#
# A _residual plot_ is a scatterplot of the residuals versus the x-variable.

elm$fitted = (-5/50) * elm$family_income + 33
elm$resid = elm$gift_aid - elm$fitted

sum(elm$resid)
sum(abs(elm$resid))

sum(elm$resid^2)
# Sum of squared errors is more conservative than sum of abs
#
# The best way to measure error is problem-specific!

# Prediction is off by about 12.5
12.5 * 1000

ggplot(elm, aes(family_income, resid)) + geom_point() +
  geom_hline(yintercept = 0)

# A linear model chooses the line that fits the data "best".
#
# Residuals measure error, so minimize residuals! How?
#
# The most popular strategy is "least squares," which minimizes the sum of the
# squared residuals. Why?

model = lm(gift_aid ~ family_income, elm)
plt + geom_smooth(method = "lm")

summary(model)

# More detail is available with the `lm()` function:


# The residuals are available using the `resid()` function or the broom
# package's `augment()` function.

resid(model)

library(broom)
df = as_data_frame(augment(model))

ggplot(df, aes(family_income, .resid)) + geom_point() +
  geom_hline(yintercept = 0)

# Conditions for linear models:
#
# 1. Linearity! The data should follow a straight line. If there is any other
#    pattern (such as a parabola) a linear model is not appropriate.
#
# 2. Independent observations. The observations should not depend on each
#    other. As an example, a time series would violate this condition.
#
# 3. Constant variance. Observations should be roughly the same distance from
#    the line.
#
# 4. Gaussian residuals. In order to construct confidence intervals for or test
#    the model, the residuals must have a Gaussian (normal) distribution.
#
# Conditions 1, 3, and 4 can be checked with residual plot(s). Condition 4 can
# also be checked with a quantile-quantile (Q-Q) plot.
#
# For condition 2, think carefully about whether it makes sense for your data
# that the observations would be indpendent.


# ### Example: Anscombe's Quartet
# Do the statistics tell you everything?

df = readRDS("data/anscombe.rds")

lapply(split(df, df$group), function(subs) lm(y ~ x, subs))

ggplot(df, aes(x, y)) + geom_point() + facet_wrap(~ group)


# Multiple Regression
# -------------------
# Often more than one variable is related to the response variable. Multiple
# regression fits a model with more than one term:
#
# y = b0 + (b1 * x1) + (b2 * x2) + ...

# ### Example: Mario Kart Sales
# Auction data from Ebay for the game Mario Kart for the Nintendo Wii.

library(openintro)

?marioKart

mario = as_data_frame(marioKart)

model = lm(totalPr ~ cond + nBids + wheels + duration, mario)
summary(model)

df = as_data_frame(augment(model))

ggplot(df, aes(nBids, .resid)) + geom_point()

# For more details, see chapters 5-6 from:
#
# <https://www.openintro.org/stat/textbook.php?stat_book=isrs>


# The Anscombe data was converted to a tidy data frame from R's built-in
# `anscombe` data with the following function.
tidy_anscombe = function() {
  df = as_data_frame(anscombe)
  df$observation = seq_len(nrow(anscombe))

  # Move values to rows labeled with the column they came from.
  df = gather(df, label, value, x1:y4)
  # Split the "label" column into two columns: (x or y, group #)
  df = extract(df, label, c("xy", "group"), "([xy])([1-4])")
  # Move values to two columns for x and y.
  spread(df, xy, val)
}

