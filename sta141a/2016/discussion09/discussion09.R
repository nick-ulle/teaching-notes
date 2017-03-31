# discussion09.R
#
# Week 8
# ------

# Regex tutorial: https://regexone.com/
#
# 11/28 office hours will be moved to a different day (TBA).


# Reading Files
# -------------
# To read a plain text file into R, use readLines().
#
# Alternatively, the readr package has read_lines() and read_file().
#
# Use list.files() to get a vector of file names.

x = paste0(readLines("discussion09.R"), collapse = "\n")

library(readr)
x = read_file("discussion09.R")

files = list.files("cache", full.names = TRUE)

text = sapply(files, read_file)

# Use lapply/sapply to read the files, then do regex OUTSIDE the apply.


# Web Scraping
# ------------
# Two different options for web scraping:
#
# 1. RCurl and XML
# 2. xml2 (and optionally curl, rvest)
#
# Both may have bugs.
#
# XML              | xml2           | Description
# ---------------- | -------------- | -----------
# getURLContent()  | curl()         | download a web page
# htmlParse()      | read_html()    | parse a web page
# saveXML()        | write_xml()    | save a web page
# getNodeSet()     | xml_find_all() | extract tags by XPath
#                  | html_nodes()   | extract tags by CSS Selector
# xmlValue()       | xml_text()     | extract text inside of a tag
# xmlGetAttr()     | xml_attr()     | extract an attribute on a tag
# getRelativeURL() | url_absolute() | convert relative URL to absolute URL
#
# The XML package has been around for a long time, but receives updates
# infrequently. It has lots of options (see the help files) to give the user
# full control.
#
# The xml2 package is part of Tidyverse and all functions are vectorized. It
# has a simple interface but fewer features. The rvest package is an add-on
# that allows you to use CSS selectors.


# HTML documents are structured like a tree, similar to your computer's file
# system. XPath is a language for writing paths to tags in an HTML document.
#
# XPath      | Description
# ---------- | --------------------------
# /          | tag separator (one sublevel)
# //         | tag separator (any sublevel)
# .          | current tag
# ..         | parent tag
# *          | any tag
# @          | attribute prefix
# |          | either xpath ("or" for xpaths)
# []         | tag index or condition
# and, or    | boolean operators
# not()      | negation
# contains() | check string x contains y
# text()     | get tag text
#
# CSS Selectors are another way of writing paths to tags in an HTML document.
#
# For interactive tutorials:
#
# * http://www.topswagcode.com/xpath/
# * http://flukeout.github.io/


# ### Problem: Scrape Recipe Ingredients from SeriousEats.com
