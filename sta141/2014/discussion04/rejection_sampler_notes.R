# An example of writing a rejection sampler.

# Step 1: Sample an x coordinate from the proposal.
x = rprop(1)

# Step 2: Sample a y-coordinate from Uniform(0, cg(x)).
y = runif(1, 0, C * dprop(x))

# Step 3: Accept if (x, y) is under f.
if (y < f(x)) {
  # Accept!
}

# Now make a loop out of it.
accepted = 0
samp = vector('numeric', 7)
while (accepted < 7) {
  x = rprop(1)
  y = runif(1, 0, C * dprop(x))
  if (y < f(x)) {
    # Accept! Store x.
    accepted = accepted + 1
    samp[accepted] = x
  }
}

# Finally, make a function.
rnormtrunc = function(n) {
  samp = numeric(n)
  accepted = 0
  # RUN  while accepted <  n
  # STOP when  accepted >= n

  while (accepted < n) {
    # Step 1: Sample x.
    x = rprop(1)

    # Step 2: Sample y.
    y = runif(1, 0, C * dprop(x))

    # Step 3: Accept/reject.
    if (y < f(x)) {
      # Accept! Store x.
      accepted = accepted + 1
      samp[accepted] = x
    }
  }
  samp
}
