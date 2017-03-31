# discussion07.R

# ----- Code Formatting ----


# ----- Using sapply -----
a <- 1:20
a

tan(a)

sapply(a, function(x) tan(x))

mean(a)
tapply(a, groups, mean, na.rm = TRUE)

# ----- Warnings, Errors -----
f <- function() {
  warning("This line is bad!")
  5
}

f()

f <- function() {
  stop("This line is bad!")
  5
}

f()

# ----- Loading Files -----

# Use file to open a file on your computer for
# reading or writing.
# The parameter open tells R what you're planning
# to do with the file. Some examples:
#   "r" or "rt"   read a text file
#   "w" or "wt"   write to a text file
#   "a" or "at"   append to a text file

airports <- file('data/FiveAirports.csv', 
                 open = 'r')

# Use readLines to read a line from an open file.
# The second parameter specifies how many lines
# to read.
readLines(airports, 1)

# R will keep track of what line you're at in the
# file.
readLines(airports, 1)

# Close files you are done using with close.
close(airports)

# Let's try writing to a file:
output <- file('Hello.txt', 'w')
writeLines("Hello, world!", output)
writeLines("This is line 2.", output)
# It's especially important to close files you
# opened for writing.
close(output)

# R can open a lot more than local files.
# For instance, websites:
stats <- url('http://anson.ucdavis.edu/',
             open = 'r')
readLines(stats, 10)
close(stats)

# R can also read from the clipboard.
clipboard <- file('clipboard', open = 'r')
readLines(clipboard, 1)

# To avoid the warning that there is no end of
# line, use:
readLines(clipboard, 1, warn = FALSE)

close(clipboard)

# Similarly, R can write to the clipboard:
clipboard <- file('clipboard', open = 'w')

pasted <- paste0('String ', 1:3, collapse = ' ')
pasted

writeLines(pasted, clipboard)

close(clipboard)

# ----- Profiling -----
# To time your code, use system.time.
# You can use normal expressions inside of
# system.time, but if you want to do assignment
# you must use <- instead of =
system.time(a <- 5)
a

slowFunction <- function() {
  for (i in 1:1000) {
    str <- "Patagonia"
    paste0(substr(str, 1, 3), 1:i)
  }
}

system.time(slowFunction())

# Many commands execute so quickly that
# system.time just reports 0s. If you want to
# compare two commands like this, try timing
# 1000 or 10^6 runs of each. You can use
# functions for this!

timeIt <- function(f, n = 100, ...) {
  system.time(
    for (i in 1:n) {
      f(...)
    }
  )
}

testFunction <- function(x) {
  paste0(rep('Test', x), collapse = '|')
}
testFunction(5)

testFunction(10)
timeIt(testFunction, 10^6, 10)

# We can also use Rprof for more detailed
# profiling.

Rprof('profile.out')
testFunction(10)
slowFunction()
Rprof(NULL)

summaryRprof('profile.out')
