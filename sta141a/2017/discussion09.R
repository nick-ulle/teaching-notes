# STA 141a
# ========
# TA: Nick Ulle
#     naulle@ucdavis.edu
#
# Office Hours:
#   Ben           M     2-4         MSB 1143
#   Nick          M     4-6         EPS 1317
#   Prof. Gupta   ?     ?           ?
#   Jiahui        F     3:30-5:30   MSB 1143

# I have extra office hours today from 11-1pm in MSB 1147.
#
# Since I have to walk to MSB they may start a few minutes
# after 11.

# Infographic:
#   https://www.shipmap.org/

# k-Nearest Neighbors
# -------------------
#
# 1.  Compute distance from every test point to every
#     training point.
#
# 2.  For each point in the test set:
#     b.  Find k closest training points.
#     c.  Get the class labels for the k closest training
#         points.
#     d.  Count how many times each class label appears.
#     e.  Predict the class label with the highest count.


# 10-Fold Cross-Validation
# ----------------
#
# 1.  Randomly split the data into 10 pieces.
#     a. Shuffle the data.
#     b. Split the data into 10 pieces.
#
# 2.  Take 1 piece as the test set and use the other 9 as
#     the training set.
#
# 3.  Fit the model on the training set.
#
# 4.  Predict for the test set.
#
# 5.  Use the predictions to compute the error rate.
#
# 6.  Repeat 2-5 so each of the 10 pieces has a chance to
#     be the test set.
#
# 7.  Compute the mean (or median) of the 10 error rates.


# Efficiency Improvements
# -----------------------

# You have to cross-validate for many different choices of
# k and distance metric. 
#
# So you might have to compute distances 30x or more!
#
# Is there a faster way to do this?
#
# Changing k does not change the distances.
#
#
# So if you reuse the distances you only need to compute
# the distances 2x (once for each distance metric).
