# Discussion9.R

# Office Hours
# ============
# Homework 4 pickup in OH today!
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
#
#

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

url = "http://news.ycombinator.com"

library(curl)
library(xml2)

# Now we scrape! For each article, get:
#   * Title
#   * Comments URL
#   * Top Comment
#

# Basic idea of checking for cached version
html =
if (file.exists("hackernews.html")) read_html("hackernews.html")
else read_html(url)

write_xml(html, "hackernews.html") # Cache the file
# For Duncan's packages use saveXML()
# Use one or the other: Duncan's or Hadley's packages

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

# Get the title.
# Look for <tr class="athing">
xpath = "//tr[@class='athing']"
athings = xml_find_all(html, xpath)

xpath = "./td[@class='title']/a"
title = xml_find_all(athings, xpath)
title = xml_text(title)

scrape = data.frame(title = title)

# Get comment URL.
xpath = "//td[@class = 'subtext']"
subtexts = xml_find_all(html, xpath)

# Check how many tags are underneath <td class="subtext">
# It would be nice to use xml_length(subtexts),
# but this is buggy.
n_children = sapply(subtexts, xml_length)
valid = (n_children == 4)

xpath = "./a[contains(text(), 'comment')
  or contains(text(), 'discuss')]"
# xpath = "./a[3]"
c_url = xml_find_all(subtexts[valid], xpath)
c_url = xml_attr(c_url, "href")

scrape$comment_url = NA
scrape$comment_url[valid] = url_absolute(c_url, url)

# Get top comment for each post.
get_top_comment = function(comment_url) {
  if (is.na(comment_url)) return(NA)
  html = read_html(comment_url)
  xpath = "(//span[@class ='comment']/span)[1]"
  comment = xml_find_all(html, xpath)
  xml_text(comment)
}

get_top_comment(scrape$comment_url[1])
comments = sapply(scrape$comment_url, get_top_comment)
