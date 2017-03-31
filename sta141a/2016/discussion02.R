# discussion02.R

# Week 1
# ======
# For motivation to learn R, check out this list of news articles based on real
# data:
#
# <https://github.com/wbkd/awesome-interactive-journalism>

# The first assignment has been posted! Start early, you'll have questions.


# Loading Data, Part 1
# ====================
# Most of the time, data you're interested in must be loaded from an external
# source.
#
# For example, there's lots of data available online:
#
# * US Federal Government <https://www.data.gov/>
# * CA State Government <http://data.ca.gov/>
# * FiveThirtyEight <https://github.com/fivethirtyeight/data>


# Data can come in many different formats, each with pros and cons.
#
# An "extension" is a short string at the end of a file's name (after the last
# dot) that indicates the format.
#
#   my_great_file.png
#                 ^----- The extension is "png".
#
#   not.quite.as.great.but.pretty.good.jpg
#                                      ^----- The extension is "jpg".
#
# Note:
# * Extensions can be incorrect!
# * File names aren't required to have extensions.
# * Changing an extension DOES NOT change the file's format.
#
# Extension | Format                  | Tabular? | R Function | Tidyverse
# --------- | ----------------------- | -------- | ---------- | ---------
# .rda      | R data                  |          | load       |
# .rds      | R data                  |          | readRDS    |
# .csv      | comma-separated values  | yes      | read.csv   | read_csv
# .tsv      | tab-separated values    | yes      | read.delim | read_tsv
# .fwf      | fixed-width format      | yes      | read.fwf   | read_fwf
# .xlsx     | Excel spreadsheet       | yes      |            | read_excel
# .html     | hypertext markup        |          |            | read_html
# .xml      | extensible markup       |          |            | read_xml
# .txt      | plain text              | maybe    | readLines  | read_lines


# The base R functions work on any computer that has R. These are important to
# know!
#
# The Tidyverse functions are faster and have a consistent interface. However,
# they're only available if the Tidyverse package is installed.


# File Paths
# ==========
# Before loading a file, R needs to know where the file is!
#
# A path is a string that lists the directories on the way to the file. So
#
#     /home/nick/my_file.py
#
# means `my_file.py` is in the `nick` directory in the `home` directory.
#
# Windows uses `\` as the path separator, but `/` will work in R on all
# operating systems.
#
# An "absolute path" starts from the top directory of the file system, which is
# `/` on Linux/OS X and `C:\` on Windows. Example:
#
#     /home/nick/university/teach/sta141a/data/dogs.csv
#     C:\my_docs\dogs.csv


# A program's "working directory" is the directory where the program will look
# for files.
#
# Use getwd() to check R's working directory.
getwd()

# Use list.files() to see the files in R's working directory.
list.files()

# A relative path starts from the working directory. Example:
#
#     data/dogs.csv
#
# Relative paths make it easier for other people to run your code, which is a
# good thing!
#
# Directory above current is ..
#
#     ../hw1.pdf


# Loading Data, Part 2
# ====================
# RDA files store data in a binary format (not human-readable) that only R can
# read.
#
# RDA files automatically create variables in your workspace when loaded. That
# means loading an RDA file can overwrite your variables!

load("data/demo_data.rda")


# RDS files are similar to RDA files, but don't automatically create variables
# when loaded.
#
# RDS files are ideal for storing data between R sessions.
x = c(2, 4, 8)
saveRDS(x, "data/a_number.rds")

x = 42
y = readRDS("data/a_number.rds")


# CSV files store tabular data in a text format. Each line is a row and columns
# are separated by commas.
#
# CSV is a great format for sharing data with others, because humans, most
# programming languages, and Excel can read CSV files.

read.csv("data/dogs.csv", skip = 3)

# For Tidyverse:
library(readr)
dogs = read_csv("data/dogs.csv", skip = 3)

read_csv("data/dogs.csv")

# Excel files store data in a binary format.
library(readxl)
xls = read_excel("data/demo_workbook.xlsx")
xls2 = read_excel("data/demo_workbook.xlsx", 2)


# Data Frames
# ===========
# Statistical data is traditionally arranged in tables where:
#
# * Each row represents one observation.
# * Each column represents one measurement (or "covariate").
#
# R stores tabular data in "data frames", which always have class `data.frame`.
typeof(dogs)
class(dogs)

# Functions useful for inspecting data:
#
# * head(), tail()
# * nrow(), ncol(), dim()
# * str()
# * typeof(), class()
# * rownames(), colnames(), names()
# * table()
head(dogs, 3)
tail(dogs, 3)

nrow(dogs)
ncol(dogs)

rownames(dogs)
colnames(dogs)

# A data frame is really just a list of vectors!
typeof(dogs)
unclass(dogs)

# Computing Subsets
# =================
# The subset operator `[` selects by name, index, or a condition.
x = c(a = 5.8, b = NA, c = 3.2, d =  -4.5)

# By name:
x["a"]

x[c("b", "d")]

# By index (position):
x[1]

x[1:2]
x[c(1, 2)]

# Remove elements by position:
x[-1]

# By a condition (which is really just a logical vector):
x[c(FALSE, FALSE, FALSE, TRUE)]

x < 0

x[x < 0]

!is.na(x)
x[!is.na(x)]

# Use the subset operator to reassign elements of a vector.
x[1] = 20
x

# The subset operator also works on data frames and matrices. The syntax is
#
#   x[ROWS, COLUMNS]
#
# Leave ROWS or COLUMNS blank to keep all of them.

dogs
dogs[1]

# First row.
dogs[1, ]

# First column.
dogs[, 1]

# Breed column for rows 4-6.
dogs[4:6, "breed"]


# Extracting Values
# =================
# The `[[` operator extracts a single element from an R object, by name or
# index.
#
# Note that for lists (and data frames) a single element could be a vector!

# Use `[[` to extract by name or index.
x[["a"]]

x[[1]]

class(dogs["breed"])

class(dogs[["breed"]])

dogs[[1]]

# It's easy to confuse the subset operator `[` with the extraction operator
# `[[`. There are two differences:
#
# 1) `[[` extracts a single element, whereas `[` can get many.
#
# 2) `[[` peels off lists, whereas `[` keeps them.
#
# For #2, recall that lists are like boxes around other objects.
my_list = list(3, 5, 7)

my_list[1]
typeof(my_list[1])

my_list[[1]]
typeof(my_list[[1]])


# Subset & Extraction Shortcuts
# =============================
# The `$` operator extracts a single element from an R object by name.
x$a

dogs$breed

# The subset() function is a shortcut for `[` for data frames.
subset(dogs, breed == "Poodle")

# Note that subset() is meant for interactive use. Avoid it when writing
# functions for others to use, since it uses non-standard evaluation.
breed = "Cat"
breed == "Poodle"
subset(dogs, breed == "Poodle")



