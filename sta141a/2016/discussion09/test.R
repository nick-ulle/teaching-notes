# Download recipe files and save them to the cache.

library(xml2)
library(dplyr)
library(stringr)

main = function(cache = "cache") {
  urls = readLines("recipes")

  if (!dir.exists(cache))
    dir.create(cache)

  recipes = lapply(urls, function(url) {
    recipe = fetch_recipe(url, cache)
    parse_recipe(recipe, url)
  })
  recipes = do.call(rbind, recipes)

  re = "([0-9 /]+) (?:(ounce|cup|pound|teaspoon|tablespoon|large|medium)s? )?(.*)"
  qty = str_match(recipes$ingredient, re)
  recipes$quantity = qty[, 2]
  text = qty[, 3]
  browser()
}


parse_recipe = function(doc, url) {
  li = xml_find_all(doc, "//li[@class = 'ingredient']")
  data_frame(ingredient = xml_text(li), url = url)
}


fetch_recipe = function(url, cache) {
  # Get file name.
  path = file.path(cache, basename(url))

  if (file.exists(path))
    return (read_html(path))

  doc = read_html(url)
  write_xml(doc, path)
  return (doc)
}
