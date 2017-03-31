# Office Hours
# ============
# Go to office hours...it's the right thing to do.
#
# Charles:  MWF 8 - 9am     MSB 1117
# Nick:     M   4 - 5:30pm  EPS 1316
#           W   1 - 2:30pm  MSB 4208
# Duncan:   T/R Around 12?  MSB 4210

# Homework Guidelines
# ===================
# Reports must:
# - have sections/questions clearly indicated (in order)
# - have answers clearly differentiated from code (as
#   opposed to commented in randomly)
# - answer the questions explicitly, more than just code
# - must include plots if asked for in question or
#   referenced in answer
# - plots must be clean, clear, and well-labeled
# - be shorter than 15pgs (I had many that were 30+)
#   [print on both sides, smaller font, etc.]

# Filesystems
# ===========

# Get the current directory with getwd().
getwd()

# Change the current directory with setwd().
setwd('D:/Projects')
getwd()

setwd('Teaching/2014.09 sta141/Discussion4/')
getwd()

# Get a vector of all files in the current directory with
# list.files().
list.files()

# Change to SpamAssassinTraining directory.
setwd('SpamAssassinTraining/')

# Get list of subdirectories.
dirs = list.files()
dirs

# Iterate over subdirectories.
for (dir in dirs) {
  # Change to current subdirectory.
  setwd(dir)
  # List files in subdirectory.
  files = list.files()
  for (f in files) {
    # do something to file `f`
    # process_email(f)
    print(f)
  }
  # Go back up to the parent directory.
  setwd('..')
}

# Input
# =====

# read.table() reads tabular data.
read.table('dogs.txt')
?read.table

# read.csv() reads comma-separated values (CSV) data.
read.csv('dogs.csv', row.names = 1)
?read.csv

# read.dcf() reads colon-separated (key: value) pairs.
courses = read.dcf('courses.txt')
?read.dcf
courses[, 1:2]

# What about everything else?

# The file() function opens a file. Make sure to close it
# when you're done!
con = file('courses.txt', open='rt')
?file

# The readLines() function reads the specified number of
# lines from a connection.
readLines(con, 1)
?readLines

# Read all remaining lines.
readLines(con)

# Close a file with close().
close(con)

# String Processing
# =================
addr = '56789 Shields Ave, Davis, CA 95616'

# Get the number of characters with nchar().
nchar(addr)

# Remove a substring with substr(). The syntax is:
#   substr(TEXT, START, STOP)
substr(addr, 1, 5)

substr(addr, 7, 17)

# Split a string using strsplit().
strsplit(addr, ', ')

# Even more string manipulation functions are available in
# the 'stringr' package.

# Regular Expressions
# ===================
# Regular expressions describe patterns of characters.
# They are tricky.

# Do you need lots of regular expressions for assignment 3?
# Probably not!

text = c('cat dog mouse', 'turnip radish onion',
         'snake hawk cat')

# grepl() checks whether the pattern can be found.
grepl('dog', text)
grepl('chocolate', text)

# grep() returns the indexes of the elements that contain
# the pattern.
grep('cat', text)
grep('onion', text)

# gsub() substitutes something wherever the pattern is
# found.
gsub('dog', 'llama', text)

# MAGIC:
#
# .     any character
# ^     beginning of string
# $     end of string
#
# [ab]  match 'a' or 'b'
# [^a]  match any character except 'a'
#
# *     previous character appears 0 or more times
# +     previous character appears 1 or more times
# ?     previous character appears 0 or 1 times
# {N}   previous character appears exactly N times
# {N, } previous character appears at least N times
#
# *?    non-greedy *
# +?    non-greedy +
# ??    non-greedy ?
#
# ()      make a group
# (ab|c)  match 'ab' or 'c'
#
# \\    escape (make the next character non-magical)
# \\N   back reference (match contents of Nth group)

# strsplit() also uses regular expressions!
tt = 'spooky.!spooky.?lemon..cookie'
strsplit(tt, '[.]')

strsplit(tt, '[.][!?.]')


# Iteration Review
# ================
# 1 Before you use a iteration:
#   Do you want to do something repeatedly?
#   Can it be done with vectorization? (within reason)
#
# 2 What do you want to happen in a single iteration?
#   Is there a built in function that does what you
#   want? If there isn't, write and test code to handle
#   just the first iteration.
#
# 3 Next: What are you iterating over? That is, which
#   variable changes on each iteration? This is called
#   the iterate.
#   How would your code change to handle the second
#   iteration?
#
# 4 Once you identify the iterate:
#   Replace the iterate with a variable, and wrap
#   everything in a function definition that takes the
#   variable as a parameter.

for (i in 1:4) {
  message = paste0('This is iteration ', i)
  print(message)
}

# The browser() tells R to pause execution and give you
# control.
for (i in 1:4) {
  browser()
  message = paste0('This is iteration ', i)
  print(message)
}

sapply(1:4, function(x) browser())

f = function() {
  x = 5
  browser()
  sin(10)
  log(10)
}

f()

# Using non-integers as loop counters can have strange
# results.
i = 0
while(i < 0.8) {
  print(i)
  if (i == 0.7) browser()
  i = i + 0.1
}

i = 0
for (j in 1:1e6) {
  i = i + 0.1
}
format(i, scientific = FALSE, nsmall = 10)
i - 1e5

# Avoid using non-integers as loop counters.
# If you want to iterate over non-integers, use a sequence.
seq(0, 0.7, 0.1)
for (i in seq(0, 0.7, 0.1)) {
  print(i)
}

# More information about the machine precision is available
# in .Machine.
.Machine
str(.Machine)
?.Machine

# Functions Review
# ================

# The return() statement means "return immediately". So a
# return() in a loop usually doesn't make sense.
foo = function() {
  for (i in 1:4) {
    return(i) # STOP EXECUTION NOW!
  }
}

foo()

bar = function() {
  added = 0
  for (i in 1:4) {
    added = added + i
  }
  list(added, i)
}

bar()

sapply(1:4, function(x) {
  rep(x, 3)
})

# Try to avoid using global variables in your functions.
A = matrix(1:6, 2, 3)
num = 6

# BAD:
na.num = function(x) {
  # `num` isn't defined locally
  x[x == num] = NA
  x
}

na.num(A)

# The behavior of the function changes depending on external
# variables (not good!).
num = 1
na.num(A)

# GOOD:
# Parameters are made just for changing the behavior of a
# function, so use them instead.
na.num = function(x, num = 6) {
  x[x == num] = NA
  x
}

na.num(A)
na.num(A, 1)

# Your functions should be self-contained! The only
# exception is using other functions.
shuffle = function(x) sample(x, length(x))

my.cool.function = function(x) {
  if (length(x) < 2)
    stop('x must have length > 2')

  x = shuffle(x)
  x[2] = x[2] + 1
  x[1] = 42
  # Shuffle again for good measure.
  shuffle(x)
}

my.cool.function(1:5)

# Passing arguments through with ...:
y = c(1, 2, NA)
foo = function(x, ...) {
  mean(x, ...)
}

bar = function(x, ...) {
  foo(x, ...)
}
bar(y, na.rm = TRUE)
