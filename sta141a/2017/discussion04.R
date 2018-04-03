# STA 141a
# ========
# TA: Nick Ulle
#     naulle@ucdavis.edu
#
# Office Hours:
#   Ben           M     2-4         MSB 1143
#   Nick          M     4-6         EPS 1317
#   Prof. Gupta   TR    1:30-3:30   MSB 4240
#   Jiahui        F     3:30-5:30   MSB 1143  **NEW**


# Infographic:
#   http://hedonometer.org/

 
# Statistical Models
# ------------------
# "All models are wrong, but some are useful." -- G. Box
dogs = readRDS("data/dogs/dogs_full.rds")

plot(weight ~ height, dogs)

model = lm(weight ~ height, dogs)
abline(coef(model))

plot(model)

summary(model)

plot(model, which = 1) # check linearity (model)
plot(model, which = 2) # check normality (tests)
plot(model, which = 3) # check constant variance (model, tests)
plot(model, which = 4) # check outliers
plot(model, which = 5) # check outliers ** (model)

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


# Merging Data Sets (Joins)
# -------------------------
# A data set split across multiple tables is _relational_.
#
# A feature that appears in more than one table is called a
# _key_, and connects the tables.
#
# Relational data saves storage for data sets with more
# than one kind of observation.
#
# For instance: How can we store a data set with info about
# singers (1) and their albums (2)?
# 
# Most singers have more than one album!
#
# This ia _one-to-many_ relationship.
#
# ONE artist -> MANY albums
#
# If we use 1 table with a row for each album, there will
# be lots of duplicated info. This wastes storage.
#
# Instead, use 2 tables: one for singers and one for
# albums. Link them by the singer's name or an ID number.
#
# Sometimes you'll need to combine relational data into one
# table. Combining separate tables is called _joining_
# them.

parts = readRDS("data/sp/parts.rds")
supplier_parts = readRDS("data/sp/supplier_parts.rds")
suppliers = readRDS("data/sp/suppliers.rds")

# How many parts does Smith have? Or Jones?
#
# Join tables in R with the `merge()` function.

merge(supplier_parts, suppliers, by = "SupplierID",
  all = T)

# Use the `all` parameter to force all rows from both
# tables to show up.

merge(supplier_parts, suppliers, by = "SupplierID",
  all = T)

# Use the `by` parameter to specify the key. If the name of
# the key is different for the two tables, use `by.x` and
# `by.y`.

merge(supplier_parts, suppliers, by.x = "SupplierID",
  by.y = "supplier_id", all = T)

# What if we wanted to merge all 3 data frames?

merge(s, sp, by = "SupplierID", all = TRUE)

merged = merge(s, sp, by = "SupplierID")
final_merge = merge(merged, p, by = "PartID")

names(final_merge)[5] = "SupplierCity"
names(final_merge)[10] = "PartCity"
head(final_merge)

final_merge[c("SupplierName", "PartName", "Qty")]


# Transforming Matrices
# ---------------------
# In R, a matrix is just a vector with dimensions.
#
# You flatten a matrix into a vector with `c()`.

m = matrix(1:6, 3, 2)

m

c(m)

# Notice that the matrix is stored in column-order. The
# vector has the elements of the first column, then the
# second column, and so on.
#
# This is useful for changing the shape of tabular data
# that is not tidy.

rownames(m) = c("A", "B", "C")
colnames(m) = c("2001", "2002")

# Flatten the year columns into one column.

tidy = data.frame(
  value = c(m),
  # Repeat ABC ABC
  month = rep(c("A", "B", "C"), times = 2), 
  # Repeat 2001 2001 2001   2002 2002 2002
  year = rep(c("2001", "2002"), each = 3)
)

tidy


# How To Solve Problems
# ---------------------
#
# Break the problem into small steps. Why?
#
# 1. Divide & Conquer: small steps are easier to work out
#    correctly.
#
# 2. Testing: make sure each step works before moving on to
#    the next.
#
# 3. Reuse: some steps may be useful for solving other
#    problems.
#
#
# Problem-solving Checklist:
#
# 1. What do you want to do? You can't write the code if
#    you don't understand the problem!
#
#    Work out a simple example by hand (yes, by hand). Draw
#    pictures.
#
# 2. Are there any built-in functions that help solve the
#    problem?
#
# 3. Start by programming the example you worked out by
#    hand.
#
# 4. Generalize your code. How does it break? Fix it!
