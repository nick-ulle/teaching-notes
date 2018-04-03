# STA 141a
# ========
# TA: Nick Ulle
#     naulle@ucdavis.edu

# Please fill out TA evals!

# Infographic:
#   http://flowingdata.com/2017/10/19/american-daily-routine/

# What's Next
# -----------
#
# *   141B uses Python. The focus is on data extraction:
#     text processing, web scraping, and databases.
#
# *   141C uses R, Python, and C. The focus is on
#     performance and strategies for working on "big"
#     problems.


# Web-Scraping
# ------------
# Two different options for web scraping:
#
# 1. XML (and RCurl)
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
# The XML package has been around for a long time, but
# receives updates infrequently. It has lots of options
# (see the help files) to give the user full control.
#
# The xml2 package is part of Tidyverse and all functions
# are vectorized. It has a simple interface but fewer
# features. The rvest package is an add-on that allows you
# to use CSS selectors.


# HTML documents are structured like a tree, similar to
# your computer's file system. XPath is a language for
# writing paths to tags in an HTML document.
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
# CSS Selectors are another way of writing paths to tags in
# an HTML document.
#
# For interactive tutorials:
#
# * http://www.topswagcode.com/xpath/
# * http://flukeout.github.io/

# ### Problem:
#     Scrape Recipe Ingredients from SeriousEats.com
#
# 1. Download (and cache) the pages.
# 2. Extract text from the pages with XPath or CSS
#    Selectors.

# Bold: <em><strong>Hi</strong></em> my name is Nick!

library(dplyr) # for data_frame()
library(rvest) # for html_nodes()
library(xml2)

main = function(cachedir = "cache") {
  # The starting point of our scraper.
  urls = readLines("recipes")

  if (!dir.exists(cachedir))
    dir.create(cachedir)

  pages = lapply(urls, function(url) {
    parse_page(fetch_page(url, cachedir), url)
  })
  pages = do.call(rbind, pages)

  # Use regex here on the entire ingredients column.
  # ...

  # See what's going on or return the data.
  browser()
}

parse_page = function(page, url) {
  li = xml_find_all(page, "//li[@class = 'ingredient']")
  ingredients = xml_text(li)
  data_frame(ingredient = ingredients, url = url)
}

fetch_page = function(url, cachedir) {
  # Download a page and cache it.
  # Cached to cachedir/basename
  cache = file.path(cachedir, basename(url))

  # Load from cache if possible; otherwise web.
  if (file.exists(cache)) {
    return (read_html(cache))
  }

  page = read_html(url)
  write_xml(page, cache)
  page
}
