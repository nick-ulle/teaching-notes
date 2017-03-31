
# DON'T DO THIS:
ord = t(apply(distance, 1, order))

apply(ord, 1, function(row) {
  train_labels[row][1:k]
})



# INSTEAD:
#
ans = apply(distance, 1, function(row) {
  train_labels[order(row)][1:k]
})

ans = t(ans)

# Split indexes into 5 groups

n = 20
indexes = 1:n

shuffle = function(x) sample(x, length(x))

# (Optional) Set seed once at beginning of code.
# Only once!
set.seed(1)
rnorm(1)
rnorm(1)

indexes = shuffle(indexes)

groups = rep(1:5, len = n)
test_sets = split(indexes, groups)

n_folds = 5
groups = rep(1:n_folds, length(indexes))
split(indexes, groups)

sapply(1:20, function(k) {
  cross_validate(data, k, metric)
})

sapply(1:5, function(fold_no) {
  3.1 + fold_no
})
