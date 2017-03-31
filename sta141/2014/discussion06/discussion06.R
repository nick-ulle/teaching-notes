# discussion06.R

# Office Hours
# ============
# In Boston, the R language is called 'Aah'.
# Also, go to office hours.
#
# Charles:  MWF   8 - 9am     MSB 1117
# Nick:     M     4 - 5:30pm  EPS 1316
#           W     1 - 2:30pm  MSB 4208
# Duncan:   T/R   See Piazza  MSB 4210
#
# ============

# Student Questions
# =================

# Q: How can I use nchar() to count all characters
# that aren't spaces?
nchar(gsub(' ', ''. str))

# Q: What does unlist() do when there's a list
# inside of a list?
a = list(30, list(30, 11))
a
unlist(a)

# Q: How does lapply() work?
x = c(1, 2, 3, 4)
y = lapply(x, print)

x = list(1, 2, 3, 4)
y = lapply(x, function(x.element) x.element^2)

x[[1]]
x[1]

# Q: How does textConnection() work?
str.vec = c('a', 'b', 'c', 'd')
con = textConnection(str.vec)
readLines(con, 1)
readLines(con)
close(con)

# Q: How can I reset a connection?
seek(con, 1)

# ========

# A better way to loop over the files:
paths = list.files('SpamAssassinTraining/',
                   recursive = TRUE)
for (path in paths) {
  # process_email(path)
  print(path)
}

# Or an lapply:
lapply(paths, process_email)

# This avoids using the current working directory,
# which is a global variable.

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
grepl('.', 'a')
grepl('.', '6')
grepl('.', ' ')
grepl('.', '')

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
grepl('\\^', 'a')


# Escaping a \ requires four:
grepl('\\\\', '\\')

# Treat the entire regex literally:
grepl('^$.', 'ssga^$.', fixed = TRUE)

# The ^ marks the beginning of the string.
grepl('^a', 'ab')
grepl('^a', 'ba')

grepl('a^a', 'ab')

# The $ to marks the end of the string.
grepl('a$', 'ab')
grepl('a$', 'ba')

# If you don't mark the beginning and end, the
# match can be
# made anywhere! Forgetting this is an easy
# mistake.
grepl('a', 'bab')
grepl('^a', 'bab')

# Square brackets
#   [SYMBOLS]
# match any of the SYMBOLS inside, exactly once.
str1
grepl('[ez]', str1)

str2
grepl('[ez]', str2)

grepl('^[ez][ez]$', 'ez')

# Square brackets can also specify a range
#   [START-END]
grepl('[0-9]', '6')
grepl('[a-zA-Z0-9]', ' ')

# Character classes:
grepl('[[:alpha:]]', 'a')
?regex

# Square brackets starting with ^,
#   [^SYMBOLS]
# match anything except the SYMBOLS inside, exactly once.

grepl('[^a-z]', 'q')
grepl('[^a-z]', '1')
grepl('[^a-z]', 'A')

# ^ only works for negation at beginning
grepl('[a-z^]', 'A')

grepl('^[0-9][0-9]$', '120')
grepl('[a-z^A-Z]', '^')
grepl('[^[:space:]]', 'a')

grepl('[a-z]', '-')
grepl('[a-z-]', c('-', 'a', 'A'))
grepl('-', '-')

# The quantifiers ?, *, and + are used as
#   X?
# where X is any symbol.

# The ? specifies that the symbol should appear
# exactly 0 or 1 times.
grepl('^z?a', 'a')
grepl('^z?a', 'za')
grepl('^z?a', 'zza')

grepl('z?', '')

grepl('z?', 'The quick brown fox')

# The * quantifier specifies 0 or more times.
grepl('^z*a', 'a')
grepl('^z*a', 'zzzzzzza')

# The + quantifier specifies 1 or more times.
grepl('^z+a', 'a')
grepl('^z+a', 'zzza')

grepl('x[[:space:]]*y', 'x   y')

# The curly braces quantifier
#   X{N}
# matches X exactly N times.
grepl('[a-z]{3}', 'aa')
grepl('[a-z]{3}', 'abc')
grepl('[a-z]{3} ', 'abcd')

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
grepl('^[a-z]{0,3}', 'aaaa15153535')
grepl('^[a-z]{0,3} ', ' 15153535')

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
grepl('(la){3}', 'lalala')
grepl('(la){3}', 'lalal')

grepl('^([ld]a){3}', 'laadada')
grepl('([ld]a){3}', 'larara')

# The text that matched a group can be referred
# to later in
# the pattern, with
#   \N
# where N = 1, 2, ... is the number of the group.
# This is
# called a backreference.
regex = 'We saw ([a-zA-Z-]+), but \\1 was busy.'
grepl(regex, 'We saw Duncan, but Duncan was busy.')
grepl(regex, 'We saw Jane-Ling, but Jane-Ling was busy.')

grepl(regex, 'We saw Duncan, but Jane-Ling was busy.')

# A pipe character
#   PATTERN1|PATTERN2
# matches one of PATTERN1 or PATTERN2. This is most useful
# in groups.
grepl('This is my (cat|tiny ocelot).',
      'This is my cat.')

grepl('This is my (cat|tiny ocelot).',
      'This is my tiny ocelot.')

grepl('cat|dog', 'saber-tooth cat')

# A look-ahead
#   (?=PATTERN)
# matches PATTERN but doesn't count as part of the match.
# This is useful for splits and substitutions.
strsplit('hello', 'll')
strsplit('hello', 'l(?=l)')
strsplit('hello', '(?=el)', perl = TRUE)

# R's Regex Functions
# ===================
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
regex = '([0-9]{1,2}):([0-9]{2})( am| pm|)'
replacement = "It's \\2 minutes past \\1\\3."
gsub(regex, replacement, '10:30 am')
gsub(regex, replacement, '1:15 pm')
gsub(regex, replacement, '2:10')

# Quantifiers are greedy, so they try to chomp up as much of
# the string as possible. Adding an extra ? makes them back
# off.
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
