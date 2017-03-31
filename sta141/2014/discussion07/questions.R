
# 9-10am Section
# ==============

# Q: How can I count the number of times a
# certain character appears in a string?
string = 'She sells seashells by the seashore.'
esses = gsub('[^Ss]', '', string)
nchar(esses)

count.char = function(character, string) {
  pattern = paste0('[^', character, ']')
  nchar(gsub(pattern, '', string))
}
count.char('Ss', string)

# Q: Review of . in regex:
pattern = '.'
grepl(pattern, 'a')
grepl(pattern, 'dgrteryr')
grepl('[.]', 'a')
grepl('[.]', '.')
grepl('\\.', '.')
grepl('\\.', 'a')

# Q: paste0 vs paste?
string1 = 'cat'
string2 = 'grapefruit'
paste(string1, string2)
paste0(string1, string2)
?paste0


# Q: How to get 3rd element?
splitted = strsplit('hello-goodbye-yes', '-')
splitted
splitted[3]
splitted[[1]]
splitted[[1]][3]

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

strsplit(c('hello-goodbye-yes', 'cat-grapefruit'),
         '-')

# Q: Homework 4 data and report format?

# 2-3pm Section
# =============
# Q: How to use regmatches()?
string = '505-555-1234'
regex = '[0-9]{3}-'
regmatches(string, gregexpr(regex, string))

regmatches(string, regexpr(regex, string))
regexpr(regex, string)

regmatches(string, regexec(regex, string))
regexec(regex, string)

# Q:
str_match_all('hello.ababab.goodbye.abababab',
              '\\.(ab){3}(.{2})')

pattern = '^(cat|dog) \\1'
str_detect('cat cat', pattern)
grepl(pattern, 'cat cat', perl = TRUE)
str_detect('cat', pattern)
str_detect('cat dog', pattern)
