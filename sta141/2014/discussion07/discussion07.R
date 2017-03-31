# discussion07.R

# Office Hours
# ============
#
# Charles:  MWF   8 - 9am     MSB 1117
# Nick:     M     4 - 5:30pm  EPS 1316
#           W     1 - 2:30pm  MSB 4208
# Duncan:   T/R   See Piazza  MSB 4210

# ==================
# Questions, Please!

# 9-10am Questions
# ================

# Q: How can I count the number of times a
# certain character appears in a string?

# Remove everything except that character, then
# use nchar():
string = 'She sells seashells by the seashore.'
esses = gsub('[^Ss]', '', string)
nchar(esses)

# We can make a function for this:
count.char = function(character, string) {
  pattern = paste0('[^', character, ']')
  nchar(gsub(pattern, '', string))
}
count.char('Ss', string)

# ...of course, one is already availble in the
# stringr package.

# Q: How does '.' work in regular expressions?

pattern = '.'
# '.' matches any character...
grepl(pattern, 'a')
grepl(pattern, 'dgrteryr')
# ...unless you put it in brackets or escape it
# with backslashes:
grepl('[.]', 'a')
grepl('[.]', '.')
grepl('\\.', '.')
grepl('\\.', 'a')

# Q: What's the difference between paste() and
# paste0()?
string1 = 'cat'
string2 = 'grapefruit'
paste(string1, string2)
paste0(string1, string2)
?paste0

# Q: How can I get the third element if I split
# a string into 3 parts?
splitted = strsplit('hello-goodbye-yes', '-')
splitted
splitted[3]
# strsplit() returns a list, so extract first
# element of list first:
splitted[[1]]
splitted[[1]][3]

# The reason for returning a list is that
# strsplit() is vectorized:
strsplit(c('hello-goodbye-yes', 'cat-grapefruit'),
         '-')

# Q: Is unlist() better than [[1]] in the previous
# question?

# Using [[1]] makes it clear that we want only the
# first element of the list. Also, it's more
# efficient:
foo = function(x) {
  splitted = strsplit('hello-goodbye-yes', '-')
  unlist(splitted)
}

bar = function(x) {
  splitted = strsplit('hello-goodbye-yes', '-')
  splitted[[1]]
}

system.time(sapply(1:10000, foo))
system.time(sapply(1:10000, bar))

# Q: Homework 4 data and report format?

# Submit a data frame with emails as rows and
# variables as columns. In the report, you should
# analyze at least 5 variables to see how they
# behave for spam versus nonspam. The goal is to
# explore the variables so you have some idea of
# which will work well for classification.

# 2-3pm Questions
# ===============
# Q: How to use regmatches()?
string = '505-555-1234'
regex = '[0-9]{3}-'
regmatches(string, gregexpr(regex, string))

regmatches(string, regexpr(regex, string))
regexpr(regex, string)

regmatches(string, regexec(regex, string))
regexec(regex, string)

# Q: How do parenthesis work in regular
# expressions?

# The parentheses create a 'capture group', which
# groups part of the pattern together. Any
# quantifiers after the parentheses get applied
# to the entire pattern inside.

# Repeat 'itsy ' or 'bitsy ' two times:
pattern = '(b?itsy ){2}spider'

str_detect('itsy itsy spider', pattern)
str_detect('itsy bitsy spider', pattern)

str_detect('itsy spider', pattern)

# Don't match itchy spiders:
str_detect('itchy itchy spider', pattern)

# You can refer back to a capture group by using
# a backreference.

# 'cat' or 'dog' at the begining of a string,
# followed by the same thing again:
pattern = '^(cat|dog) \\1'

str_detect('cat cat', pattern)
# Make sure to use perl = TRUE with R's built-in
# functions.
grepl(pattern, 'cat cat', perl = TRUE)
str_detect('cat', pattern)
str_detect('cat dog', pattern)

# 4-5pm Questions
# ===============
# Q: What does gregexpr() do?
pattern = 'c[^ ]*'
string = 'dog coconut dog cat'
matched = gregexpr(pattern, string)
regmatches(string, matched)

# Q: How can I extract an attribute (such as
# those in the output of gregexpr())?
attr(matched[[1]], 'match.length')

# Q: What are attributes?

# Attributes are extra metadata attached to a data
# structure.
x = c(5, 6)
x
attr(x, 'weight') = c(1, 2)
x

# More Regex
# ==========
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

# Text Encodings
# ==============
# Computers store information as binary numbers.
# An 8 bit binary number is a byte.

# A byte can be represented by two base-16 digits.
# The base-16 number system is called hexadecimal,
# It uses 0-9 and A-F (so there are 16 digits).
# For example,
#   A is 10
strtoi('0xA')
#   B is 11
strtoi('0xB')
#   AA is A*16 + A*1 = 10*16 + 10*1 = 170
strtoi('0xAA')

# To store text, computers encode characters as
# binary numbers!
#
# For example (in ASCII),
#
#   0110 0001 (0x61), #97 is 'a'
#   0110 0010 (0x62), #98 is 'b'
#   0110 0011 (0x63), #99 is 'c'
#   ...
#   0110 1001 (0x69), #105 is 'i'
#   0110 1010 (0x6A), #106 is 'j'
#   0110 1011 (0x6B), #107 is 'k'
#
# How many characters can be stored with 1 byte
# (8 bits)?
2^8

# How many characters are there in English?

# English & Greek?

# English & Greek & Russian?

# English & Greek & Russian & Chinese?

# English & Greek & Russian & Chinese & ... ?

# In the beginning, different countries used
# encodings that worked with their language.

# This became a big problem! (why?)

# In the late 1980s, two big tech companies
# decided to do something about it. (who?)

# They came up with a new standard: Unicode
# Characters would be encoded using ~2.5 bytes
# (20 bits). This allows for a lot of characters:
2^20

# Over 1 million!

# The only problem is that using more bytes per
# character takes a lot of space. Suddenly a text
# file is 2.5 times bigger.

# To solve this, they made the encoding
# variable-length. One implementation is UTF-8.

# In UTF-8, the first few bits specify the length
# of the character.
#
#   7 bits:   0xxx xxxx
#   11 bits:  110x xxxx 10xx xxxx
#   16 bits:  1110 xxxx 10xx xxxx 10xx xxxx
#   20 bits:  1111 0xxx 10xx ...
#
# The 7-bit numbers match ASCII. For example:
#
#   0x61, #97 is still 'a'
#
# The 11-bit and 16-bit numbers are used for
# common characters in other languages:
#
#   0xc394, #916 is 'Δ'
#   0x8aac, #29356 is '犬'
#
# Higher numbers are used for less common
# characters (e.g. ancient Egyptian Hieroglyphs).

# UTF-8 is the most popular format for Unicode,
# but other formats exist. Windows uses UTF-16.

# So what does this have to do with R?
l10n_info()
Sys.getlocale("LC_CTYPE")

# Several people got the warning:
#   "Input string 1 is invalid in this locale"

# Change stat.dir to the directory above the
# SpamAssassinTraining folder.
stat.dir = 'D:/Projects/Teaching/2014.09 sta141/'
path = paste0(stat.dir,
              'SpamAssassinTraining/spam/',
              '0253.',
              'f715f442da45114754198a160195b883')

extract.subject = function(x) {
  # Find the subject line.
  subject.line = grep("Subject:", x)
  x[subject.line]
}

# Read the file.
email = readLines(path)
subject = extract.subject(email)
subject

# R has no idea what the proper encoding is.
Encoding(subject)

# Try again, but specify the encoding.
email = readLines(path, encoding = "UTF-8")
subject = extract.subject(email)
subject
Encoding(subject)

# Specifying the encoding will prevent grepl()
# from complaining about the locale.

# Another example. To replicate this example,
# make a file containing the characters ΓΔ犬
path = paste0(stat.dir, 'Discussion6/unicode.txt')
text = readLines(path)
text
Encoding(text)

text.utf8 = readLines(path, encoding = 'UTF-8')
text.utf8
Encoding(text.utf8)

pattern = 'Î'
# Matches with the wrong encoding:
grepl(pattern, text)
# Doesn't match with the correct encoding:
grepl(pattern, text.utf8)
# Despite the correct encoding, matches when
# useBytes = TRUE.
grepl(pattern, text.utf8, useBytes = T)
This setting makes the regex
# useBytes = TRUE means search byte-by-byte
# instead of character-by-character. Avoid it
# unless you're sure that's what you want!
