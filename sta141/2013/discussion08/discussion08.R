# discussion08.R

# ----- Regular Expression Functions -----

str1 <- 'pears apples'
str2 <- 'lemons oranges'
str.vec <- c(str1, str2)[c(1, 2, 1, 1, 2)]
addr <- '56789 Shields Ave, Davis, CA 95616'

# Regular expressions are patterns for searching
# within a string.
regex <- 'o'

# grepl() returns whether or not the input string 
# (i.e. characters) match the pattern.
str1
grepl(regex, str1)

str2
grepl(regex, str2)

str.vec
grepl(regex, str.vec)

# grep() returns which elements of the input
# character VECTOR matched the pattern.
grep(regex, str1)

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
gregexpr(regex, str2)

gregexpr(regex, str.vec)

# regexec() does the same thing as regexpr(), but
# returns the result as a list.
regexec(regex, str.vec)

# You can use regexpr (or gregexpr, or regexec) 
# with regmatches() to extract the match.
regmatches(str.vec, regexpr(regex, str.vec))

regmatches(str.vec, gregexpr(regex, str.vec))

# sub() substitutes a value wherever it finds
# the pattern.
sub(regex, 'Z', str1)

sub(regex, 'Z', str2)

sub(regex, 'Z', str.vec)

# gsub() does this globally.
gsub(regex, 'Z', str.vec)

# ----- Regular Expressions -----
# Now more on regular expressions. The power is
# in using 'meta-characters'. These characters
# have special meanings in a regular expression.

# The square brackets [] are used as:
#   [SYMBOLS] 
# and match any of the SYMBOLS inside.
str1
grepl('[lp]', str1)

str2
grepl('[lp]', str2)

# Ranges specified with - can be used inside of 
# square brackets.
grepl('[0-9]', '6')
grepl('[a-zA-Z]', ' ')

# You can also match anything except the SYMBOLS
# by starting with ^
grepl('[^a-z]', 'q')
grepl('[^a-z]', '1')

grepl('[a-z-]', '-')

# The . matches any character.
grepl('.', 'a')
grepl('.', '6')

# To match only a dot, you need to 'escape' the
# meta-character with a backslash. This makes it
# a normal character. Because R also treats
# backslashes in strings as magic, you need TWO
# backslashes.
grepl('\.', '.')
grepl('\\.', '.')
grepl('\\.', 'a')

# The ^ matches the beginning of the string.
grepl('^a', 'ab')
grepl('^a', 'ba')

grepl('a', 'ba')

# The $ matches the end of the string.
grepl('a$', 'ab')
grepl('a$', 'ba')

grepl('a', 'ba')

# The quantifiers (e.g. ?, *, +) are used as:
#   X?
# where X is any symbol. 

# The ? specifies that the symbol should appear 
# exactly 0 or 1 times.
grepl('^z?a', 'a')
grepl('^z?a', 'za')
grepl('^z?a', 'zza')

grepl('z?', '')

# The * quantifier specifies 0 or more times.
grepl('^z*a', 'a')
grepl('^z*a', 'zzza')

# The + quantifier specifies 1 or more times.
grepl('^z+a', 'a')
grepl('^z+a', 'zzza')

# The curly braces quantifier is used as:
#   {N}
# to specify exactly N times.
grepl('[a-z]{3}', 'aa')
grepl('[a-z]{3}', 'abc')
grepl('[a-z]{3}', 'abcd')

# They can also be used as {M,N} to specifiy
# at least M times, at most N times.
grepl(' [a-z]{0,3} ', ' aaaa15153535')

# Also {M,} to specify at least M times, with no
# maximum.
grepl('^[a-z]{3, }$', 'abcd')

# The parantheses () create a 'capture group'.
# These can be referred to later in the pattern
# with a back reference \N, where N = 1, 2, ... 
# is the number of the group.
grepl('([a-z]{3})\\1\\2', 'catjet')
grepl('([a-z]{3})\\1', 'catcat')
grepl('([a-z]{3})([a-z]{3})\\1\\2', 'catdogcatdog')

# You can also use back references with sub()
# and gsub():
gsub('([a-z]{3}).{3}', '\\1', 'catjet')

# Quantifiers are greedy, so they try to chomp
# up as much of the string as possible.
gsub('.*(.*)', '\\1', 'some text')

# You can make them reluctant by adding a ?.
gsub('(.*?)(.*)', '\\2', 'some text')

# Finally, you can use the vertical bar | in a
# capture group to indicate either side of the
# bar is a match. The technical word for this
# is an 'alternation'.
grepl('(cat|dog)', 'cat')
grepl('(cat|dog)', 'dog')
grepl('(cat|dog)', 'toucan')

# and now... to the Linux shell!
