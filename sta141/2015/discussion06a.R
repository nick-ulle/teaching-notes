
# DON'T DO THIS!
ord_mat = t(apply(D, 1, order))
apply(ord_mat, 1, function(row) train[row, ])

# INSTEAD:
my_order_func = function(row, myvar) {
  train[order(row), ]
}

apply(A, 1, my_order_func, myvar = 5)

# Combine back-to-back apply functions


# -------------

# Don't do this with a for loop!

ans = list()
for (row_id in 1:nrow(A)) {
  ans[row_id] = train[order(A[row_id, ]), ]
}
