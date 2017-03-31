# discussion01.R

# ----- Contact Info -----

# Name:     Nick Ulle
# Email:    naulle@ucdavis.edu
# Office:   MSB 1220

# Office Hours (in Stats TA Office, MSB 1117):
#   M   2-3pm
#   W   2-4pm

# Duncan's Office Hours:
#   T   2-3:30pm
#   Th  9-10:30pm

# ----- R Fundamentals -----

# ?? and ?
??'box plot'
?boxplot

# class: how does it behave?
?class

class(8)

a <- matrix(8, 2, 2)
a

class(a)

b <- data.frame()
class(b)

# typeof: what is it?

typeof(42)
typeof(42.0)
typeof(42L)
typeof(TRUE)

typeof(a)
typeof(b)

# ls: what's in our workspace?
ls()

# rm: clean out our workspace!

# ----- Loading Data -----

# getwd, setwd, dir
getwd()
setwd('D:/data')
dir()

# load
load('housing.rda')

# read.table, read.csv, scan, etc...
airline <- read.csv('2012_December.csv')

?scan

# ----- Manipulating Data -----

# Inspecting data with nrow, ncol, length, dim, head, tail
dim(housing)
nrow(housing)
ncol(housing)

length(housing)

head(housing)
tail(housing)

names(housing)
colnames(housing)

summary(housing)

# Subsetting with [ and [[
head( housing['br'] )
head( housing[['br']] )

head( housing[c('br', 'county')] )

# Subsetting rows
head( subset(housing, br == 1) )

head( housing[housing$br == 1, ] )

# More subsetting with $
head(housing$br)

head(housing$county)

# Looping with apply, sapply, and tapply

tapply(housing$lsqft, housing$county, mean)
tapply(housing$lsqft, housing$county, mean, na.rm = TRUE)

# ----- Graphics -----

# Basic Plotting: plot, points, lines, abline
price_table <- tapply(housing$price, housing$county, mean)

barplot(price_table, cex.names = 0.65)

# Formula Notation:
plot(price ~ lsqft, housing)
boxplot(housing$price ~ housing$county, pch = 4, cex = 0.25)

# Customizing graphics: par
?plot.default
?points
?par

# Lattice : focused on flexibility and complex graphs, with an 
# emphasis on grouping and comparing data. Powerful, but 
# complicated.
library(lattice)

# ggplot2: focused on the "grammar of graphics," an abstract way 
# to think about visualization. Elegant, but slow.

# Saving graphics: pdf, png
pdf('plot.pdf', 6, 6, paper = 'letter')
barplot(table(housing$br))
dev.off()

png('plot.png', width = 6, height = 6, units = 'in', res = 600)
barplot(table(housing$br))
dev.off()

# ----- Example: Anscombe's Quartet -----
anscombe

# Compute statistics for the data.
colMeans(anscombe)
sapply(anscombe, sd)

# Make visualizations.
boxplot(anscombe)

# Order the data so we can draw nice lines.
ans_sorted <- anscombe[order(anscombe$x1), ]

# Make a plot showing each pair of variables.
plot(y1 ~ x1, ans_sorted, type = 'b', col = 'red', pch = 16,
     xlab = 'x', ylab = 'y', main = "Anscombe's Quartet",
     xlim = range(ans_sorted[1:4]), ylim = range(ans_sorted[5:8]))

lines(y2 ~ x2, ans_sorted, type = 'b', col = 'blue', pch = 16)

lines(y3 ~ x3, ans_sorted, type = 'b', col = 'green', pch = 16)

points(y4 ~ x4, ans_sorted, pch = 4, cex = 0.75)
