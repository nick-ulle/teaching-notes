# Discussion9.R

# Office Hours
# ============
# Homework 4 pickup today (follow me after) or Monday!
#
# Nick      M   4-6pm       EPS 1316
# Duncan    TR  See Piazza  MSB
# Nick      F   9-11am      MSB 1143
#
# Please fill out TA evaluations!!!

# Questions?
# ==========
#
# Part I
# ~ 3 - 9 small functions for each item
# 1 function for scraping a page
# 1 function for scraping all pages (top level)
# ~ 300 lines of code (Nick did it in 150)
#
# build url based on tag (last part)

library(curl)
library(xml2)

url = "http://stackoverflow.com/questions/tagged/r"
html = read_html(url)

xp = "//div[@class = 'user-details']"
user_details = xml_find_all(html, xp)

sapply(user_details, function(node) {
  # Check if node has rep score or not
})

# Scraping
# ========
# We'll scrape HackerNews using Hadley's packages.

#   Duncan                Hadley
#   ------------------------------------
#   getURLContent()   ~   curl()
#   htmlParse()       ~   read_html()
#   getNodeSet()      ~   xml_find_all()
#   xmlValue()        ~   xml_text()
#   xmlGetAttr()      ~   xml_attr()
#   getRelativeURL    ~   url_absolute()

url = "http://news.ycombinator.com"

library(curl)
library(xml2)

# Now we scrape! For each article, get:
#   * Title
#   * Comments URL
#   * Top Comment
#

html = read_html(url)

xp = "//tr[@class='athing']"
athings = xml_find_all(html, xp)

xp = ".//td[@class='title']/a"
title = xml_find_all(athings, xp)
title = xml_text(title)

scrape = data.frame(title = title)

# Extract comment link
xp = "//td[@class='subtext']"
subtexts = xml_find_all(html, xp)
subtexts

# How many children?
n_children = sapply(subtexts, xml_length)
valid = (n_children == 4)

scrape$comment_url = NA

# Look for <a> surrounding text with "comment"
# or "discuss"
xp = ".//a[contains(text(), 'comment')
  or contains(text(), 'discuss')]"
c_url = xml_find_all(subtexts[valid], xp)
c_url = xml_attr(c_url, "href")
scrape$comment_url[valid] =
  url_absolute(c_url, url)

# Get top comment for each article.
get_top_comment = function(url) {
  if (is.na(url)) return(NA)
  # Assume url is real, get page.
  html = read_html(url)
  xp = "(//span[@class='comment']/span)[1]"
  comment = xml_find_all(html, xp)
  xml_text(comment, trim = TRUE)
}
get_top_comment(scrape$comment_url[[1]])

scrape$top_comment =
sapply(scrape$comment_url, get_top_comment)

# Firebug

#   XPath         Meaning
#   ----------------------------------------
#   /             tag separator (one sublevel)
#   //            tag separator (any sublevel)
#   .             current tag
#   ..            parent tag
#   *             any tag
#   @             attribute prefix
#   |             either xpath ("or" for xpaths)
#
#   []            tag index or condition
#   and, or       boolean operators
#   not()         negation
#
#   contains()    check string x contains y
#   text()        get tag text
