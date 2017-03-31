# discussion08.R

# Office Hours
# ============
# Homework 3 pickup in OH (after 9:45) today!
#
# Nick      M   4-6pm       EPS 1316
# Duncan    TR  See Piazza  MSB
# Nick      F   9-11am      MSB 1139 (TODAY ONLY)

# Questions?
# ==========

# Q:  Sometimes my regular expression matches a string in
#     several places. How can I just get the first match?

# A:  For base R, use regexpr() instead of gregexpr(). The
#     "g" stands for global, so gregexpr() returns every
#     match. On the other hand, regexpr() only returns the
#     first match.
#
#     For stringr, use the functions that don't have "_all"
#     at the end of their name.

test = c("555-5555 555-5551", "555-1234", "")
regex = "[0-9]{3}-[0-9]{4}"

# Only first match:
regmatches(test, regexpr(regex, test))

library(stringr)
str_match(test, regex)

# All matches:
regmatches(test, gregexpr(regex, test))

str_match_all(test, regex)


# Q:  Why should I use stringr?

# A:  The main advantage of stringr is that it's organized
#     to be easy to use. All of the functions start with
#     "str_" and have similar parameters:
#     
#         str_foo(STRING, REGEX)
#
#     As a bonus, stringr includes a few functions for
#     common tasks that would require several steps using
#     only base R.

# Count number of Ss in a string:
string = "sassasfrass"

str_count(string, "s")

# Count number of Ss in a string with base R:
nchar(gsub("[^s]", "", string))


# Q:  What's the best way to match the ".com", ".net", and
#     so on at the end of email addresses? Should I just
#     list them (using "|") in my regular expression?

# A:  The ".***" suffix on email addresses is called a
#     "top level domain." There are hundreds of valid top
#     level domains, and there's no restriction on how many
#     characters they can be.
#
#     So if you want to be able to match *any* email
#     address, listing top level domains isn't a good
#     strategy.
#
#     In practice, only a few top level domains, like
#     ".com", are common. So if you want to extract email
#     addresses that aren't separated from the next word,
#
#       "janedoe@gmail.comis my email address"
#
#     then listing top level domains is the most practical
#     way to do it.


# Q:  What should I do to model vehicle prices in
#     assignment 4?

# A:  You're free to use any model that makes sense for
#     a continuous response variable (price). For instance,
#
#       * linear regression 
#       * regression trees (packages: rpart, tree, etc...)
#       * neural networks
#
#     You can also bin the prices and then use a method for
#     categorical response variables, such as k-nearest
#     neighbors. Keep in mind that by binning the prices,
#     you lose information and your predictions will be
#     less specific.


# Q:  How can I replace missing values (NAs) in one vector
#     with corresponding values from a different vector?

x = c(1, NA, 2, 5, NA)
y = c(1, 3, NA, 5, 7)

# Fill out NAs in x from values in y:
na_elements = is.na(x)
x[na_elements] = y[na_elements]


# Q:  How can I match one vector of strings against
#     another?

# A:  Since the regex functions are only vectorized in the
#     string argument (but not the regular expression
#     argument), you'll have to use a loop. Something like
#     an mapply() would be the most appropriate.

x = c("Toyota", "Honda", "Toyota", "Jeep")

mapply(function(maker, body) {
  # Build a regular expression with sprintf(), paste().
  # ...

  # Run a regex function.
  # ...

  # Return the car model.
  return(model)
}, vposts$makers, vposts$body)


# Approximate Regular Expressions
# ===============================
# The functions agrep() and agrepl() perform approximate
# matching.

# The "distance" between strings is the number of
# insertions, deletions, and substitutions you'd have to
# make to get from one to the other.
#
# For example, "Hello" and "Hello!!" have distance 2,
# because you would need to insert the 2 !s to change 
# "Hello" into "Hello!!". R has a function for computing
# string distances:
adist("Hello", "Hello!!")

# Use the "max.distance" parameter to control how similar
# a string has to be to your regular expression in order to
# be a match. Integer values specify string distance.

agrepl("Mazda", "Mfda", max.distance = 2)

agrepl("Mazda", "Mfda", max.distance = 1)

# Keep in mind that the pattern matching follows the usual
# rules for regular expressions! So

agrepl("Hello", "Hello!!", max.distance = 1)

# matches for the same reasons

grepl("Hello", "Hello!!")

# matches! This can be tricky because substitutions are
# allowed when measuring distance. For instance,

agrepl("xHellox", "xHello!!x", max.distance = 1)

# matches "xHellox" with the substring "xHello!".

# You can use non-integer values for "max.distance" to
# specify the distance as a percentage of string length.
# So 0.2 would mean the max distance is 20% of the string's
# length.

# Also note that agrepl() and agrep() don't support | or
# any perl regular expressions (like "\\1")! However, they
# do support [].
grepl("(Duncan) is \\1", "Duncan is Duncan", perl = T)
agrepl("(Duncan) is \\1", "Duncan is Duncan")

# To extract matching words with agrepl() or agrep(), split
# the text into words BEFORE matching.


# Greedy Quantifiers
# ==================
# Quantifiers (?, *, +) are greedy, so they try to match as
# much of a string as possible. Adding an extra ? makes
# them non-greedy.

string = 'Tuna tuna please deliver!'
replacement = 'Meow-mix '
gsub('([Tt]una )+', replacement, string)
gsub('([Tt]una )+?', replacement, string)

gsub('[Tt]una ', replacement, string)

# Suppose we have a string with some random number followed
# by Euler's number:
string = paste0(':', rnorm(1), ':2.7182:')
string

# If we try to replace the random number with Pi, we need
# to use a non-greedy quantifier (*?):
gsub(':(.*?):', ':3.1415:', string)

# A greedy quantiier (*) would replace too much:
gsub(':(.*):', ':3.1415:', string)

# Greedy ? versus non-greedy ??:
gsub("aa?(a+)", "\\1", c("aaaa", "aaaaa"))
gsub("aa??(a+)", "\\1", c("aaaa", "aaaaa"))


# R's Regex Functions
# ===================
str1 = 'fizzy soda'
str2 = 'strong coffee'
str.vec = c(str1, str2)[c(1, 2, 1, 1, 2)]
str.vec

regex = 'z'

# grep() returns which elements of the input
# character VECTOR matched the pattern.
str1
grep(regex, str1)

str2
grep(regex, str2)

str.vec
grep(regex, str.vec)

# regexpr() returns the position in each element
# of the input character VECTOR where the pattern
# matched.
str1
regexpr(regex, str1)

str2
regexpr(regex, str2)

str.vec
regexpr(regex, str.vec)

# gregexpr() returns all of the match positions.
# The 'g' stands for 'global'.
gregexpr(regex, str1)

gregexpr(regex, str.vec)

# regexec() does the same thing as regexpr(), but
# returns the result as a list.
regexec(regex, str.vec)

# You can use regexpr (or gregexpr, or regexec)
# with regmatches() to extract the match.
regmatches(str.vec, regexpr(regex, str.vec))

regmatches(str.vec, gregexpr(regex, str.vec))

# The function
#   sub(PATTERN, REPLACEMENT, TEXT)
# replaces the first match in each element of TEXT.
sub(regex, '!', str1)

sub(regex, '!', str2)

sub(regex, '!', str.vec)

# The function
#   gsub(PATTERN, REPLACEMENT, TEXT)
# replaces the every match in each element of TEXT.
gsub(regex, '!', str.vec)

# You can also use back references with sub()
# and gsub():
regex = '.*?([0-9]{1,2}):([0-9]{2})( am| pm|).*'
replacement = "It's \\2 minutes past \\1\\3."
gsub(regex, replacement, 'xz10:30 am')
gsub(regex, replacement, '1:15 pm')
gsub(regex, replacement, '2:10')


# Stringr
# =======
# The stringr package standardizes the syntax for
# R's string manipulation functions.
install.packages('stringr')
library(stringr)

# Some useful functions:
#   str_c()       concatenate strings (paste)
#   str_detect()  detect pattern (grepl)
#   str_length()  length of string (nchar)
#   str_count()   count pattern
#   str_extract() extract pattern (regmatches)
#   str_locate()  locate pattern (regexpr)
#   str_match()   extract groups
#   str_replace() replace pattern (sub)
#   str_split()   split string (strsplit)
#   str_sub()     extract substring (substr)
#
# Most have the syntax:
#
#   str_foo(STRING, PATTERN)
#
# and a global version by adding _all:
#
#   str_foo_all()
#

str_detect('aaa', 'a')
str_detect('bbbb', 'a')
str_detect(c('aaa', 'bbbb'), 'a')

str_locate('aaa', 'a')
str_locate_all('aaa', 'a')
str_locate('catdogcat', 'cat')

str_locate_all('abac', 'a[bc]')

# Matches are non-overlapping.
str_locate_all('aaaa', 'aa')

str_locate_all(c('aaa', 'bba'), 'a')

nchar('aaa')
str_count('aaa', 'a')
nchar('sassafrass')
str_count('sassafrass', 's')
# How to do this without stringr?

# Number of times pattern appears, no overlap.
str_count('aaaa', 'aa')

string = 'testing 123-4444'
pattern = '([0-9]{3})([- .])'

str_extract(string, pattern)
regmatches(string, gregexpr(pattern, string))

str_match(string, pattern)

phone = 'john doe 505-555-1354 at 1 Shields'
pattern = '([0-9]{3})[- .]([0-9]{3})[- .]([0-9]{4})'
str_match(phone, pattern)


# A Puzzle
# ========
# Can you figure out what's going on here?
string = 'Tuna tuna please deliver!'
replacement = 'Meow-mix '

gsub("([Tt]una )?", replacement, string, perl = TRUE)

# Think carefully about what ? means!

