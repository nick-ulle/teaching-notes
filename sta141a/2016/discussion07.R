# discussion07.R

# Week 6
# ------

# Regular Expressions
# -------------------
# A sequence of characters is called a string.
str1 = 'fizzy soda'
str2 = 'strong coffee'

str.vec = c(str1, str2)[c(1, 2, 1, 1, 2)]
str.vec

# A regular expression (regex) specifies a pattern of characters, and can be
# used to search for that pattern in other strings.
regex = 'a'

# grepl() returns whether or not the input string matches the pattern.
str1
grepl(regex, str1)

str2
grepl(regex, str2)

str.vec
grepl(regex, str.vec)

# A regular expression can specify a complicated pattern in
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
grepl('.', 'b')

grepl('.', 'aa')

# To match a literal '.', you need to 'escape' the meta-character with a
# backslash. This makes it a literal character.

# For RE engine: put a \. to make a literal .
grepl('\.', '.') # doesn't work

# However, backslashes also have a special meaning in R. For instance, '\n'
# means a newline:
cat('Hello hello\n')
cat('Hello \nhello\n')

# \n newline
# \t tab
# \\ backslash
# ...
# What is \. ? R doesn't know what \. is!

# So you need TWO backslashes:
grepl('\\.', '.')
grepl('\\.', 'a')

grepl('.', '.')
grepl('.', 'a')

# This also works for escaping other
# metacharacters.
grepl('\\^', '^')
grepl('\\^', 'x')

# Escaping a \ requires four:
# '\\' for RE engine
# so `\\\\` for R
cat('\\\\')
grepl('\\\\', '\\')
grepl('[\\]', '\\')
grepl('[a]', 'a')

# Treat the entire regex literally:
grepl('.', 'a', fixed = TRUE)
grepl('^$.', 'ssga^.', fixed = TRUE)

# The ^ marks the beginning of the string.
grepl('a', 'ab')
grepl('a', 'ba')

grepl('^a', 'ab')
grepl('^a', 'ba')

# Won't match anything:
# No characters can appear before beginning!
grepl('a^a', 'a')

# The $ to marks the end of the string.
grepl('a$', 'ab')
grepl('a$', 'ba')

# If you don't mark the beginning and end, the match can be made anywhere!
# Forgetting this is an easy mistake.
grepl('a', 'bab')
grepl('^a', 'bab')

grepl('a', 'aa')
grepl('^a$', 'aa')

# Square brackets
#   [SYMBOLS]
# match any of the SYMBOLS inside, exactly once.
str1
grepl('[ez]', 'z')
grepl('[ez]', str1)

str2
grepl('[ez]', str2)

grepl('[ez]', 't')

grepl('^[ezab]$', 'eb')
grepl('^[ezab]$', 'b')

grepl('^[ez][ab]$', 'eb')

# Square brackets can also specify a range
#   [START-END]
grepl('[0-9]', '6')
grepl('[a-zA-Z0-9]', 'h')

# Character classes:
grepl('[[:alpha:]]', 'a')
grepl('[a-zA-Z]', 'a')

?regex

# Square brackets starting with ^,
#   [^SYMBOLS]
# match anything except the SYMBOLS inside, exactly once.

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
grepl('^z?a', 'ta')

grepl('^[yz]?a', 'yza')
grepl('[yz]?a', 'yza')

grepl('^[za]$', 'z')
grepl('^z?a$', 'z')

grepl('^[ez]?a', 'zea') # matches: za, ea, a
grepl('^[ez]a', 'zzeea') # matches: za, ea

grepl('z?', '')

# Think of 'z?' as ('z' or '')
grepl('^az?b', 'azb')

grepl('z?', 'The quick brown fox')

# The * quantifier specifies 0 or more times.
grepl('^z*a', 'a')
grepl('^z*a', 'zzzzzzzzzzzzzzzzpzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzza')

# The + quantifier specifies 1 or more times.
grepl('^z+a', 'a')
grepl('^z+a', 'zzzzzzzzzza')

grepl('x[[:space:]]*y', 'x                    y')

# The curly braces quantifier
#
#   X{N}
#
# matches X exactly N times.
grepl('[a-z]{3}', 'aa')
grepl('[a-z]{3}', 'abc')

grepl('^[a-z]{3}$', 'abcd')

grepl('[a-z]{3} ', 'ab cd')

grepl('^[a-z]{3}$', 'abcd')

# Curly braces can also be used as
#
#   X{M,N}
#
# to match X at least M times, but at most N times. No spaces inside {}
grepl('^[a-z]{0,3}', 'aaaa15153535')
grepl('[a-z]{0,3} ', '15153535 ')

# Use
#
#   X{M,}
#
# to match X at least M times, with no maximum.
grepl('^[a-z]{3,}$', 'abcd')

# At most:
grepl('^[a-z]{,3}$', 'aaaa')

# Parantheses create a group, and any quantifiers following a group apply to
# the entire pattern in the group.
grepl('^(la)?dida', 'ladida')

grepl('^(la)+dida', 'lalalalalaladida')

grepl('(la){3}', 'lalala')
grepl('(la){3}', 'lalal')

grepl('^([ld]a){3}', 'laddada')
grepl('([ld]a){3}', 'larara')

# The text that matched a group can be referred to later in the pattern, with
#
#   \N
#
# where N = 1, 2, ... is the number of the group. This is called a
# backreference.
regex = 'We saw ([a-zA-Z]+), but \\1 was busy.'
grepl(regex, 'We saw Haoran, but Haoran was busy.')
grepl(regex, 'We saw Haoran, but Nick was busy.')

# The pipe character
#
#   PATTERN1|PATTERN2
#
# matches one of PATTERN1 or PATTERN2. This is most useful in groups.
pattern = 'This is my (cat|tiny ocelot|little panther).'
grepl(pattern, 'This is my cat.')
grepl(pattern, 'This is my tiny ocelot.')

grepl('cat|dog', 'saber-tooth dog')
grepl('cat|dog', 'saber-tooth cat')
grepl('cat|dog', 'saber-tooth toucan')

# A look-ahead
#
#   (?=PATTERN)
#
# matches PATTERN but doesn't count as part of the match. This is useful for
# splits and substitutions.

strsplit("hello class", " ")
strsplit(c("this is my text", "hello class"), " ")

# Our desired result: c("he", "llo")
strsplit('hello', 'll')
strsplit('hello', 'l')

strsplit('hello', '(?=ll)', perl = TRUE)
strsplit('hello', '(?=l)', perl = TRUE)

strsplit('hello', '(?=l)', perl = TRUE)
strsplit('hello', '(?=el)', perl = TRUE)
strsplit('hello', '(?=z)', perl = TRUE)



# R's Regex Functions
# -------------------
str1 = 'fizzy soda'
str2 = 'strong coffee'
str.vec = c(str1, str2)[c(1, 2, 1, 1, 2)]
str.vec

regex = 'z'

# grep() returns which elements of the input character VECTOR matched the
# pattern.
str1
grep(regex, str1)

str2
grep(regex, str2)

str.vec
grep(regex, str.vec)

# regexpr() returns the position in each element of the input character VECTOR
# where the pattern matched.
str1
regexpr(regex, str1)

str2
regexpr(regex, str2)

str.vec
regexpr(regex, str.vec)

# gregexpr() returns all of the match positions. The 'g' stands for 'global'.
gregexpr(regex, str1)

gregexpr(regex, str.vec)

# regexec() does the same thing as regexpr(), but returns the result as a list.
regexec(regex, str.vec)

# You can use regexpr (or gregexpr, or regexec) with regmatches() to extract
# the match.
regmatches(str.vec, regexpr(regex, str.vec))

regmatches(str.vec, gregexpr(regex, str.vec))

# The function
#
#   sub(PATTERN, REPLACEMENT, TEXT)
#
# replaces the first match in each element of TEXT.
sub(regex, '!', str1)

sub(regex, '!', str2)

sub(regex, '!', str.vec)

# The function
#
#   gsub(PATTERN, REPLACEMENT, TEXT)
#
# replaces the every match in each element of TEXT.
gsub(regex, '!', str.vec)

# You can also use back references with sub() and gsub():
regex = '.*?([0-9]{1,2}):([0-9]{2})( am| pm|).*'
replacement = "It's \\2 minutes past \\1\\3."
gsub(regex, replacement, 'xz10:30 am')
gsub(regex, replacement, '1:15 pm')
gsub(regex, replacement, '2:10')

# Quantifiers are greedy, so they try to chomp up as much of the string as
# possible. Adding an extra ? makes them back off.
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
# -------
# The stringr package standardizes the syntax for R's string manipulation
# functions.

library(tidyverse)

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
