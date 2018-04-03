# STA 141a
# ========
# TA: Nick Ulle
#     naulle@ucdavis.edu
#
# Office Hours:
#   Prof. Gupta   TR    1:30-3:30   MSB 4240
#   Nick          M     4-6         EPS 1317
#   Jiahui        W     10-12       TBA
#   Ben           M     2-4         TBA
#
# So what's this course about?

# Infographic:
#   http://www.informationisbeautiful.net/visualizations/best-in-show-whats-the-top-data-dog/

# Advice based on the previous 4 years:
#
# * Use Piazza! Participation is the main way to get help. 
#
# * Show your work (your code is your work). We do read it.
#
# * Cite sources of ideas (including classmates).

# Phil Spector / Data Manipulation with R
 
 
 
# Arithmetic, Variables, Functions, Vectors
# -----------------------------------------

5 + 6

4 * 6

6 / 7

2 ^ 5

x = 4
x

x <- 5
x

# A function takes some values as input (called arguments) and produces 1 value
# as output (called the returned value).
#
#                 -------
#  arguments ---> |  f  | ---> returned value
#                 -------
#
# The same idea as a mathematical function.

# In R, using (or "calling") a function is written with parentheses.
sum(5, 6)

sum()

# Arguments go inside the parentheses, separated by commas.


# Even arithmetic operators are functions!
`+`(5, 6)

# Vectors

5

x = c(5, 6, 7)
x

x + 1

x + c(4, 3, 1)

# Getting Help
# ------------
# ? is the most important function in R.
# It opens the help file for a given function.
?sum
?`+`

# help() does the same thing as ?, but requires that you put quotes around the
# function name.
help("lm")

# ?? searches the help files (rather than opening one specific file).
??"linear model"



# How Your Computer Works: Files & Paths
# --------------------------------------
# Computers represent everything as 0s and 1s.
#
# Some files are human-readable (text) and some files are not (binary) unless
# you have special tools. For example, a ZIP file is binary.
#
# Is a Microsoft Word file human-readable? What about a PDF?

# The official R data format is RDS (.rds), a binary format.
#
# You can load an RDS file with readRDS().

readRDS() # doesn't work! We need to say which file to load.

# You can refer to a specific file on your computer with a "path" to the file.
#
# Separate files and directories in a path with forward slashes `/`.
#
# Technically, Windows uses backslashes `\` instead of forward slashes.
# However, backslash has a special meaning in R, so you would have to use
# double backslashes `\\`. For example,
"C:\\Users\\Jordan\\Desktop"


# In R, you can use forward slashes for Windows paths. This is usually easier.
"C:/Users/Jordan"


# A path is "absolute" if it starts from the top level directory. The top level
# directory is "/" on OS X or Linux and usually "C:/" on Windows.
"/home/nick/university/teach/sta141a/week0/dogs_top.rds"


# R focuses on one directory on your computer, called the "working directory"
# or "current directory".
#
# You can check the working directory with getwd().
getwd()

# A path that isn't absolute is "relative" to the current directory.
#
# For example, on my computer:
#
#   "/home/nick/university/teach/sta141a" is ABSOLUTE
#
#   "teach/sta141a" is RELATIVE
#
# ALWAYS USE RELATIVE PATHS!

"week0/dogs_top.rds" # based on my working directory! Yours may be different.

dogs = readRDS("week0/dogs_top.rds")


# There are a few other special symbols in paths:
#
#     ~   is your HOME directory
#     ..  is the directory above
#     .   is the current directory (not very useful)
#
# So "teach/sta141a/.." is the same as "teach".


# Working With Data
# -----------------
# A data set is "tabular" if it's organized into rows and columns.
#
# A tabular data set is "tidy" if the rows correspond to observations and the
# columns correspond to measurements (covariates/features).


# Get the number of rows with nrow(). See also the ncol(), dim(), and length()
# functions.

nrow(dogs)
dim(dogs)

# Access values with [.
dogs[2, ]

dogs[, 2]

dogs[1, 2]

# Access specific columns with $.
dogs$category


# Package Management
# ------------------
# A "package" is a bundle of code you can install in R to get additional
# functions.
#
# Packages are made by people in the R community, so there is no guarantee of
# quality!
#
# Function             | Description
# -------------------- | -----------
# install.packages()   | install packages by name
# remove.packages()    | remove packages by name
# update.packages()    | update all packages
# installed.packages() | list all installed packages
# library()            | load a package in the current session
#
# You only have to install a package once (per R installation).
#
# However, you have to load packages with library() each time you start a new R
# session.
install.packages("swirl")
update.packages()

library(swirl)

swirl()


# Making Plots
# ------------
# What plot is appropriate?
# 
# Feature     | Versus      | Plot
# ----------- | ----------- | ----
# numerical   |             | box, histogram, density
# categorical |             | bar, dot
# categorical | categorical | mosaic, bar, dot
# numerical   | categorical | box,  density
# numerical   | numerical   | scatter, smooth scatter, line


# Base R functions for making plots:
# 
# Function           | Purpose
# ------------------ | -------
# plot()             | general plot function
# barplot()          | bar plot
# dotchart()         | dot chart (use instead of bar plot or pie chart)
# boxplot()          | box and whisker plot
# hist()             | histogram
# plot(density(...)) | density plot
# mosaicplot()       | mosaic plot
# pairs()            | matrix of scatterplots
# matplot()          | grouped scatterplot
# smoothScatter()    | smooth scatterplot
# stripchart()       | one-dimensional scatterplot
# curve()            | plot a function


# See this page for more notes about making plots:
#
#     https://github.com/2016-ucdavis-sts98/notes/blob/master/graphics_guide.md
#
# The lecture will mainly cover how to use base R plots.
