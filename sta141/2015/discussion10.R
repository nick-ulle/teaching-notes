# discussion10.R

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
# Assignment 6, Part I
# ~ 3 - 9 small functions for each item
# 1 function for scraping a page
# 1 function for scraping all pages (top level)
# ~ 300 lines of code (Nick did it in 150)
#
# build url based on tag (last part)
#

# Scraping
# ========
# We'll scrape HackerNews using Hadley's packages.

#   XML                   xml2
#   ------------------------------------
#   getURLContent()   ~   curl()
#   htmlParse()       ~   read_html()
#   saveXML()         ~   write_xml()
#   getNodeSet()      ~   xml_find_all()
#   xmlValue()        ~   xml_text()
#   xmlGetAttr()      ~   xml_attr()
#   getRelativeURL()  ~   url_absolute()

url = "http://news.ycombinator.com"

library(curl)
library(xml2)

# Download and parse the page.
html = read_html(url)

# Cache the downloaded page.
write_xml(html, "hn1.html")

# Now we scrape! For each article, get:
#   * Title
#   * Comments URL
#   * Top Comment
#

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

# By inspecting the site using Firefox / Chrome,
# we see that each title appears in a <tr> with
# class "athing".
xpath = "//tr[@class = 'athing']"
athings = xml_find_all(html, xpath)

# 30 elements, which matches the web page.
length(athings)

# Now extract the title.
xpath = "./td[@class = 'title']/a"
title = xml_find_one(athings, xpath)
title

title = xml_text(title)
title

scrape = data.frame(title = title)

# Next up, we need the poster. This appears in a
# <td> with class "subtext".
xpath = "//td[@class = 'subtext']"
subtexts = xml_find_all(html, xpath)

length(subtexts)

# Extract poster.
xpath = "./a[starts-with(@href, 'user')]"
xml_find_one(subtexts, xpath)

# Something went wrong! Why?
len = sapply(subtexts, xml_length)
len

# One of the subtexts is not like the others...
subtexts[which(len == 0)]

scrape$poster = NA

valid = (len != 0)
scrape$poster[valid] =
  xml_text(xml_find_one(subtexts[valid], xpath))

scrape

# Extract comments URL.
xpath = "./a[3]"
c_url = xml_find_one(subtexts[valid], xpath)
c_url = xml_attr(c_url, "href")
c_url = url_absolute(c_url, url)

scrape$comment_url = NA
scrape$comment_url[valid] = c_url


# Extract top comment for each post.
get_top_comment = function(url) {
  if (is.na(url)) return(NA)

  # Check for a cached page.
  id = gsub(".*=", "", url)
  file = sprintf("cache/%s.html", id)
  if (file.exists(file)) url = file

  html = read_html(url)
  # Cache the file.
  write_xml(html, file)

  # Extract top comment.
  xpath = "(//span[@class = 'comment']/span)[1]"
  comment = xml_find_all(html, xpath)
  comment = xml_text(comment, trim = TRUE)
  gsub("\n.*", "", comment)
}


# Test on a comment url.
test_url = scrape$comment_url[1]
get_top_comment(test_url)

top_comment =
  sapply(scrape$comment_url, get_top_comment)

scrape$top_comment = top_comment
