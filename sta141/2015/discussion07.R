# discussion07.R

# Office Hours
# ============
# Homework 3 pickup in OH (after 9:45) today!
#
# Nick      M   4-6pm       EPS 1316
# Duncan    TR  See Piazza  MSB
# Nick      F   9-11am      MSB 1139 (TODAY ONLY)

# Questions?
# ==========

# Eliminate repetion
test = c("555-5555 555-5551", "555-1234", "")
regex = "[0-9]{3}-[0-9]{4}"
regmatches(test, gregexpr(regex, test))

str_extract(STRING, PATTERN)

nchar("sassafrass")
str_count("sassasfrass", "s")

# For emails:
# Specifically look for .com|.edu|.gov|.net|.io
# Check Wikipedia

lm(price ~ age + ..., )
# Regression trees: rpart, tree, ...
# knn (bin the prices first!)
# neural networks

x = c(1, NA, 2, 5, NA)
y = c(1, 3, NA, 5, 7)

# Fill out NAs in x from values in y:
na_elements = is.na(x)
x[na_elements] = y[na_elements]

# Approximate Regular Expressions
# ===============================
# agrep(), agrepl()

# Measure distance with substitutions, insertions,
#  deletions
# Distance between these is 2.
"Hello"
"He"
adist("Hello", "He")

grepl("Hello", "Hello!!")
agrepl("Hello", "Hello!!", max.distance = 1)

agrepl("xHellox", "xHello!!x", max.distance = 1)
adist("xHellox", "xHello!!x")

agrepl("xHello!!x", "xHellox", max.distance = 2)

agrepl("xHellox", "xHelo?!x", max.distance = 2)
"xHel!lo?"
agrepl("xHellox", "Hello", max.distance = 2)

agrepl("xHellox", "xhello?!x", max.distance = 1,
       ignore.case = TRUE)

test = c("xHello?!x", "Hello", "xhello?!x")
agrep("xHellox", test, max.distance = 0.2)

# agrepl() and agrep() don't support | or any perl
# regex: \\1
#
# Does support []

# Matching from one vector of strings into another
x = c("Toyota", "Honda", "Toyota", "Jeep")
lapply(x, function(maker) {
  # Build a regex: paste(), paste0(), sprintf()


})

function(maker, body) {
  # ...
  return(model)
}

mapply(function(maker, body) {
  # ...
  return(model)
}, vposts$makers, vposts$body)

mapply(function(x_elt, x_elt2) {
  return(sprintf("%s Hello!", x_elt))
}, x, x)

str_match("aa", "[a]+")

# Regular Expressions
# ===================
# A sequence of characters is called a string.
str1 = 'fizzy soda'
str2 = 'strong coffee'

str.vec = c(str1, str2)[c(1, 2, 1, 1, 2)]
str.vec

# A regular expression (regex) specifies a pattern of
# characters, and can be used to search for that
# pattern in
# other strings.
regex = 'a'

# grepl() returns whether or not the input string
# (i.e. characters) match the pattern.
str1
grepl(regex, str1)

str2
grepl(regex, str2)

str.vec
grepl(regex, str.vec)

# A regular expression can specify a complicated
# pattern in
# just a few characters, because certain
# non-alphabet
# characters have special meanings.
#
# These special characters are called
# metacharacters.
#
# Metacharacters:
# .     any character
# ^     beginning of string
# $     end of string
#
# [ab]  'a' or 'b'
# [^a]  any character except 'a'
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
#
# Even more:
?regex

# The . matches any character.
grepl('.', '')
grepl('.', '6')
grepl('.', ' ')
grepl('.', '')

grepl('.', 'aa')

# To match a literal '.', you need to 'escape' the
# meta-character with a backslash. This makes it
# a literal character.

grepl('\.', '.') # doesn't work

# However, backslashes also have a special meaning
# in R. For instance, '\n' means a newline:
cat('Hello hello\n')
cat('Hello \nhello\n')

# So you need TWO backslashes:
grepl('\\.', '.')
grepl('\\.', 'a')

# This also works for escaping other
# metacharacters.
grepl('\\^', '^')


# Escaping a \ requires four:
# '\\'
grepl('\\\\', '\\')
grepl('[\\]', '\\')

# Treat the entire regex literally:
grepl('^$.', 'ssga^$.', fixed = TRUE)

# The ^ marks the beginning of the string.
grepl('a', 'ab')
grepl('a', 'ba')

grepl('^a', 'ab')
grepl('^a', 'ba')

# Won't match anything:
grepl('a^a', 'a')

# The $ to marks the end of the string.
grepl('a$', 'ab')
grepl('a$', 'ba')

# If you don't mark the beginning and end, the
# match can be
# made anywhere! Forgetting this is an easy
# mistake.
grepl('a', 'bab')
grepl('^a', 'bab')
grepl('^a$', 'aa')

# Square brackets
#   [SYMBOLS]
# match any of the SYMBOLS inside, exactly once.
str1
grepl('[ez]', str1)

str2
grepl('[ez]', str2)

grepl('^[ez][ab]$', 'az')

# Square brackets can also specify a range
#   [START-END]
grepl('[0-9]', '6')
grepl('[a-zA-Z0-9]', '')

# Character classes:
grepl('[[:alpha:]]', 'a')
?regex

# Square brackets starting with ^,
#   [^SYMBOLS]
# match anything except the SYMBOLS inside,
# exactly once.

grepl('[^a-z]', 'q')
grepl('[^a-z]', '1')
grepl('[^a-z]', 'A')

grepl('[^[:space:]]', 'a')

# ^ only works for negation at beginning.
grepl('[a-z^]', '^')
grepl('[a-z^]', 'a')

grepl('[a-z^A-Z]', '^')

# Move - outside a range if you want a literal -.
grepl('[a-z]', '-')
grepl('[a-z-]', '-')
grepl('-', '-')

# The quantifiers ?, *, and + are used as
#   X?
# where X is any symbol.

# The ? specifies that the symbol should appear
# exactly 0 or 1 times.
grepl('^z?a', 'a')
grepl('^z?a', 'za')

grepl('^[ez]?a', 'zea') # matches: za, ea, a
grepl('^[ez]a', 'zzeea') # matches: za, ea


grepl('z?', '')

grepl('z?', 'The quick brown fox')

# The * quantifier specifies 0 or more times.
grepl('^z*a', 'a')
grepl('^z*a', 'zzzzzzza')

# The + quantifier specifies 1 or more times.
grepl('^z+a', 'a')
grepl('^z+a', 'zzza')

grepl('x[[:space:]]*y', 'x       y')

# The curly braces quantifier
#   X{N}
# matches X exactly N times.
grepl('[a-z]{3}', 'aa')
grepl('[a-z]{3}', 'abc')
grepl('[a-z]{3}', 'abcd')
grepl('[a-z]{3} ', 'ab cd')

grepl('^[a-z]{3}$', 'abcd')

# Q: Match a string starting with a, ending with
# d, and with any characters in between?
regex = '^a.*d$'

grepl(regex, 'd')

grepl(regex, 'ad')
grepl(regex, 'a464536363d')
grepl(regex, 'aaaaaaadddddaaaaddd')
grepl(regex, 'd46463gdadfa')
grepl(regex, 'aaaaaaadddddaaaa')

# Q: What happens if we use + instead of *?
regex = '^a.+d$'
grepl(regex, 'ad')
grepl(regex, 'aad')

# Curly braces can also be used as
#   X{M,N}
# to match X at least M times, but at most N times.
# No spaces inside {}
grepl('^[a-z]{0,3}', 'aaaa15153535')
grepl('[a-z]{0,3} ', '15153535 ')

# Use
#   X{M,}
# to match X at least M times, with no maximum.
grepl('^[a-z]{3,}$', 'abcd')

# At most
grepl('^[a-z]{,3}$', 'aaaa')

# Parantheses create a group, and any quantifiers
# following
# a group apply to the entire pattern in the
# group.
grepl('^(la)?dida', 'da')


grepl('(la){3}', 'lalala')
grepl('(la){3}', 'lalal')

grepl('^([ld]a){3}', 'laddada')
grepl('([ld]a){3}', 'larara')

# The text that matched a group can be referred
# to later in
# the pattern, with
#   \N
# where N = 1, 2, ... is the number of the group.
# This is
# called a backreference.
regex = 'We saw ([a-zA-Z-]+) (), but \\1 was busy.'
grepl(regex, 'We saw Duncan, but Duncan was busy.')
grepl(regex, 'We saw -, but - was busy.')

grepl(regex, c('We saw Duncan, but Ethan was busy.',
               'We saw Fanny, but Fanny was busy.'))

# A pipe character
#   PATTERN1|PATTERN2
# matches one of PATTERN1 or PATTERN2. This is most
# useful in groups.
grepl('This is my (cat|tiny ocelot).',
      'This is my cat.')

grepl('This is my (cat|tiny ocelot).',
      'This is my tiny ocelot.')

grepl('cat|dog', 'saber-tooth cat')

# A look-ahead
#   (?=PATTERN)
# matches PATTERN but doesn't count as part of
# the match. This is useful for splits and
# substitutions.
strsplit('hello', 'll')
strsplit('hello', 'l')

strsplit('hello', 'l(?=l)', perl = TRUE)
strsplit('hello', '(?=el)', perl = TRUE)
strsplit('hello', '(?=z)', perl = TRUE)

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

# Quantifiers are greedy, so they try to chomp up
# as much of the string as possible. Adding an
# extra ? makes them back off.
string = 'Tuna tuna please deliver!'
replacement = 'Meow-mix '
gsub('([Tt]una )+', replacement, string)
gsub('([Tt]una )+?', replacement, string)

gsub('[Tt]una ', replacement, string)

# A slightly less contrived example:
string = paste0(':', rnorm(1), ':2.7182:')
string
gsub(':(.*):', ':3.1415:', string)
gsub(':(.*?):', ':3.1415:', string)

# Also works with +, ?
".+?"
".??"

# Greedy ? versus non-greedy ??
gsub("aa?(a+)", "\\1", c("aaaa", "aaaaa"))
gsub("aa??(a+)", "\\1", c("aaaa", "aaaaa"))

# Puzzle:
gsub("([Tt]una )?", replacement, string, perl = TRUE)

gsub("([Tt]una )?", replacement, string)

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

# Approxmiate Matching
# ====================


# Split body into words!

# agrep() and agrepl() don't support | or any other
# "advanced" regex.
grepl("(Duncan) is \\1", "Duncan is Duncan", perl = T)
agrepl("(Duncan) is \\1", "Duncan is Duncan")


agrepl("xHellox", "xHello!!!!x", max.distance = 1)
adist("xHellox", "xHello!!!x")

