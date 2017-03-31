# discussion03.R

# ----- Subsetting Review ------

# The subset operator [ subsets on index (i.e., position):
a <- c(5, NA, 8, 7)
names(a) <- c('Elem1', 'Elem2', 'Elem3', 'Elem4')

a
indexes1 <- c(1, 2, 3)
a[indexes1]

# Indexes can be repeated to get an element of a
# vector more than once:
a
indexes2 <- c(1, 1, 1, 4)
a[indexes2]

# The index 0 returns nothing:
a
indexes3 <- c(0, 0, 0, 0, 0, 3)
a[indexes3]

# But indexes that are too high return NA:
a
indexes4 <- c(100, 20, 1, 1000)
a[indexes4]

# Similarly, using NA as an index returns NA:
indexes5 <- c(NA, 1, NA, 4)
a
a[indexes5]

# When all of the indexes are negative, those elements 
# get left out:
a
indexes6 <- - c(2, 3)
a[indexes6]

# When no indexes are specified, the entire vector is 
# returned:
a[]

# The subset operator [ is really just a function that R 
# gives special treatment to:
a
'['(a, indexes6)

# The subset operator can also take logical (Boolean) 
# values. TRUE means keep the element and FALSE means do 
# not keep the element:
keep_element <- c(TRUE, FALSE, TRUE, FALSE)
a
a[keep_element]

# Logical subsetting requires that TRUE or FALSE is 
# specified for each element of the vector, but R 
# recycles!
a
keep_element2 <- c(TRUE, FALSE, FALSE)
a[keep_element2]

# For a named vector, the subset operator can also take 
# names:
a
name_indexes <- c('Elem3', 'Elem1', 'Elem3')
a[name_indexes]

# Subsetting also works in multiple dimensions:
A <- matrix(1:6, 3, 2)
A
row_indexes <- c(1, 2)
col_indexes <- 1
A[row_indexes, col_indexes]

# ----- Vectors -----

# Atomic types are the smallest building blocks in R.

# A vector is a (mathematical) vector of atomic types:
a <- c(5L, 3L)
typeof(a)
class(a)

a <- c(5, 3)
typeof(a)
class(a)

a <- c(5i, 3+1i)
typeof(a)
class(a)

a <- c('a', '5')
typeof(a)
class(a)

a <- c(TRUE, FALSE)
typeof(a)
class(a)

# ----- Lists -----

# Lists are another atomic type, and act like a container
# for other objects:
list(4)
a <- list(4, TRUE, matrix(1:4, 2, 2))
names(a) <- c('Elem1', 'Elem2', 'Elem3')
a
typeof(a)
class(a)

# The subset operator works just as before. It gets the elements of by
# index, name, or a logical vector:
a[3]
typeof(a[3])
class(a[3])

# The extraction operator [[ extracts a single element 
# from the list:
a[[3]]
typeof(a[[3]])
class(a[[3]])

# It can take a name as well:
a[['Elem1']]

# The shortcut extraction operator $ does the same thing without quotes:
a$Elem1

# ----- Data Frames -----

# A data frame is actually a list.
A <- data.frame(Col1 = 1:5, Col2 = c('a', 'b', 'c', 'a', 'c'))
class(A)
typeof(A)

length(A)

unclass(A)

# ----- Factors -----

# Factors represent categorical data.

# A factor is actually a vector of integers. This is done for efficiency.
a <- A$Col2
class(a)

typeof(a)
unclass(a)

# ----- Other Tools -----
# rep creates a vector with repeated entries:
rep(1, times = 5)

a <- 1:3
a
rep(a, times = 2)
rep(a, each = 2)
rep(a, times = 2, each = 2)
rep(a, times = c(5, 3, 5))

# merge joins two data frames based on a common column:
A <- data.frame(Age = rpois(5, 3), Code = c('a', 'b', 'b', 'a', 'b'))
B <- data.frame(Code = c('a', 'b'), Species = c('Lion', 'Tiger'))
A
B
merge(A, B, by = 'Code')
names(B) <- c('Code2', 'Species')
merged <- merge(A, B, by.x = 'Code', by.y = 'Code2')

merged[order(merged$Age), ]

# RColorBrewer is a great package for getting color 
# palettes.
install.packages('RColorBrewer')
library(RColorBrewer)
display.brewer.all()
palette <- brewer.pal(3, 'Set1')
palette

# Other useful packages: maps, RGoogleMaps, ggplot2
library(maps)
map('county')
matched <- match.map('state', c('Texas', 'Arizona', 
                                'California'))
colors <- palette[matched]
colors[is.na(colors)] <- 'gray'
map('state', col = colors, fill = TRUE)

# ----- Some Lattice -----
library(lattice)

# Baseball data from http://www.seanlahman.com/
teams <- read.csv('data/Teams.csv')
salaries <- read.csv('data/Salaries.csv')

dim(teams)
names(teams)

dim(salaries)
names(salaries)

# Get mean and median salaries by year.
salary_means <- tapply(salaries$salary, salaries$yearID, mean, na.rm = TRUE)
salary_meds <- tapply(salaries$salary, salaries$yearID, median, na.rm = TRUE)

# Combine salaries into one vector, then add a categorical vector indicating
# mean/median, and also include the years.
salary <- c(salary_means, salary_meds)
statistic <- rep(c('Mean', 'Median'), 
                 each = length(salary_means))
salary <- data.frame(Salary = salary, 
                     Year = as.Date(names(salary), '%Y'),
                     Statistic = statistic)

xyplot(Salary ~ Year, salary, groups = Statistic, 
       auto.key = TRUE, type = 'l',
       main = 'American Baseball Salaries')

# How can we explore the data more? What next...?
