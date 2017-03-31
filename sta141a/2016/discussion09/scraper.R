# Scrape SeriousEats
#
# 1. Download (and cache) the pages we want to scrape.
# 2. Extract the content we want.

library(xml2)
library(dplyr)

main = function(cachedir = "cache") {
  # Starting point for my scraper.
  urls = readLines("recipes")

  # Create a cache directory:
  if (!dir.exists(cachedir)) {
    dir.create(cachedir)
  }

  pages = lapply(urls, function(url) {
    page = fetch_page(url, cachedir)
    parse_page(page, url)
  })
  pages = do.call(rbind, pages)

  browser()
}

parse_page = function(page, url) {
  xpath = "//li[@class = 'ingredient']"
  li = xml_find_all(page, xpath)
  ingr = xml_text(li)
  data_frame(ingredient = ingr, url = url)
}

fetch_page = function(url, cachedir) {
  path = file.path(cachedir, basename(url))

  # Read from disk if possible.
  if (file.exists(path))
    return (read_html(path))

  # Otherwise, download from web.
  page = read_html(url)
  write_xml(page, path)
  return (page)
}
