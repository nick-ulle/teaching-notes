# Scrape SeriousEats
#
# 1. Download (and cache) the pages.
# 2. Extract text from the pages with XPath or CSS Selectors.
# 3. Extract content from the text with vectorized regex.

library(xml2)
library(dplyr)

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
  return (page)
}
