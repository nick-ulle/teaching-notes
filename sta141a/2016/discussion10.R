# discussion10.R

# Week 10
# -------

# How the Singapore Circle Line rogue train was caught with data:
#
# https://goo.gl/Raz9FB
#

# Please fill out TA evals!

# The Bootstrap
# -------------

library(readr)
library(broom)

elm = read_tsv("../data/elmhurst.txt")

mod = lm(gift_aid ~ family_income, elm)
coef(mod)

# Residual bootstrap (resample residuals)
resid = augment(mod)

resample = function(data) {
  n = nrow(data)
  # Sample row numbers (i) rather than values (e_i)
  idx = sample(n, n, replace = TRUE)

  # Use row numbers to get new residuals (e2_i).
  res_samp = data$.resid[idx]

  # y2_i =  b_0 + b_1 * x_i    + e2_i
  y_samp =  data$.fitted       + res_samp

  # Insert new response (y_i) into data frame, keeping old covariates (x_i)
  data$gift_aid = y_samp

  # Fit the same model with new data (y2_i, x_i).
  new_mod = lm(gift_aid ~ family_income, data)

  return (coef(new_mod))
}

# Bootstrap 400 times. The replicate() function is just a nice way to write
#
#   sapply(1:400, function(i) resample(resid))
#

boot = replicate(400, resample(resid))

# Now compute statistics on the bootstrap samples. Each column is one bootstrap
# sample and each row is one statistic.
#
# For example, for 90% confidence intervals:

ci_intercept = quantile(boot[1, ], c(0.05, 0.95))
ci_slope     = quantile(boot[2, ], c(0.05, 0.95))


# In assignment 5 problem 1, part (iv) has you repeat all of steps (i)-(iii).
#
# Part (iii) is a bootstrap. Part (iv) is NOT a bootstrap, it's just a repeated
# experiment.
#
# A good strategy is to write a function that performs steps (i)-(iii) and then
# call it with an apply function. The only input to your function should be the
# random seed. So a skeleton is:

prob1 = function(seed) {
  set.seed(seed) # only set the seed once, at the beginning

  # Part 1
  # ...

  # Part 2
  # ...

  # Part 3
  # ...

  # Return widths of both the theoretical and bootstrap confidence intervals:
  return (ci_widths)
}

# Part 4
#all_ci_widths = sapply(1:10, prob1)

# ...


# Classification
# --------------
# Assignment 5 problem 2 has you use three different models for classification:
#
# * Logistic Regression: use glm(), a built-in function
# * Linear Discriminant Analysis (LDA): use lda() in package MASS
# * k-Nearest Neighbors (kNN): use knn() in package class
#
# You'll also need the predict() function to get predictions for LDA and
# logistic regression, and the table() function to create confusion matrices.
#
# Below is an example with the Spambase data set. In the Spambase data set,
# each row is one email. The columns have statistics about the emails (word
# counts, letter counts, etc) and also a classification (spam or ham).

spam = readRDS("../data/spambase.rds")

# Sample 10% of data from each class to use as test data (20% total).
n_test_half = ceiling(nrow(spam) * 0.10)

set.seed(10)
idx_test = c(
  sample(which(spam$class == "spam"), n_test_half, replace = FALSE),
  sample(which(spam$class == "ham"), n_test_half, replace = FALSE)
)

spam_test = spam[idx_test, ]
spam_train = spam[-idx_test, ]

# Fit logistic model on training data. Use family = binomial for logistic.
log_model = glm(class ~ capital_run_length_total, spam_train,
  family = binomial)

# Predict for test data. Use type = "response" to get class probabilities.
log_pred = predict(log_model, spam_test, type = "response")
# Convert predictions to 1 or 2, for category 1 or 2 respectively.
log_pred = (log_pred > 0.5) + 1
# Convert predictions to spam or ham, same category order as original data.
log_pred = levels(spam_train$class)[log_pred]

# Make a confusion matrix by tabulating true classes against predicted classes.
log_con = table(true = spam_test$class, model = log_pred)


# Steps for fitting LDA are similar to those for fitting a linear or logistic
# regression model.
#
# Use lda() from package MASS to fit the model on the training data, and use
# predict() to predict for the test data.


# Use knn() from package class for k-nearest neighbors.
library(class)

# Fit knn (k = 3) model.
knn_pred = knn(
  # Note the use of [ ] rather than $ or [[ ]].
  #
  # The knn() function expects a matrix or data frame for the train and test
  # arguments. Using $ or [[ ]] would get a vector rather than a data frame.
  #
  train = spam_train["capital_run_length_total"], # 1-col data frame
  test  = spam_test["capital_run_length_total"],  # 1-col data frame
  cl    = spam_train$class,                       # vector
  k     = 3
)

# Confusion matrix.
knn_con = table(true = spam_test$class, model = knn_pred)


