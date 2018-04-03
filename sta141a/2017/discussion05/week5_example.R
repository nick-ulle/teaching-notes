# 2017 SFPD Crime Reports
#
# Crime Report CSV file from SF Open Data:
#   https://data.sfgov.org/Public-Safety/Police-Department-Incidents/tmnf-yvry
#
# Or you can use the RDS file available on Canvas.
#
# Shapefile from Zillow:
#   https://www.zillowstatic.com/static/shp/ZillowNeighborhoods-CA.zip

library(ggmap)
library(ggplot2)
# The lubridate package makes dealing with dates a little
# easier.
#install.packages("lubridate")
library(lubridate)
library(readr)
library(sf)


make_sfpd_rds = function(
  path = "crime/sfpd_incidents.csv",
  output = "crime/2017_sfpd_incidents.rds"
) {
  # 1. Clean up the data set.
  df = read_csv(path)

  names(df) = tolower(names(df))

  df$date = mdy(df$date)

  keep = year(df$date) == 2017
  df = df[keep, ]

  df$category = factor(df$category)

  # Additional transformations
  # ...

  saveRDS(df, output)

  df
}


main = function() {
  df = readRDS("crime/2017_sfpd_incidents.rds")

  # ----------------------------------------
  # 2. When do most crimes take place?
  # A simple bar plot.
  ggplot(df, aes(hour(time))) + geom_bar()

  # A tile plot by category.
  freq = table(df$category, hour(df$time))
  freq = freq[rowSums(freq) >= 200, ]
  freq = prop.table(freq, 1)
  freq = as.data.frame(freq)
  names(freq) = c("category", "hour", "freq")

  ggplot(freq, aes(hour, category)) +
    geom_tile(aes(fill = freq), color = "white") +
    labs(fill = "Proportion of Crime Type",
      y = "Crime Type")


  # ----------------------------------------
  # 3. Where do most crimes take place?
  loc = sapply(df[c("x", "y")], function(x) mean(range(x)))
  m = get_map(loc, zoom = 12)

  ggmap(m) +
    geom_density_2d(aes(x, y), df)

  ggmap(m) +
    geom_density_2d(aes(x, y, color = category), df,
      h = 0.01, alpha = 0.5)

  # Show only top 3 categories.
  top = sort(table(df$category))
  top = tail(names(top), 3)
  df2 = df[df$category %in% top, ]

  ggmap(m) +
    geom_density_2d(aes(x, y, color = category), df2,
      h = 0.01, alpha = 0.5)

  ggmap(m) +
    stat_density_2d(aes(x, y, fill = ..level..), df,
      geom = "polygon", alpha = 0.3)


  # ----------------------------------------
  # 4. What kinds of crimes occur in each neighborhood?
  #
  # NOTE: This example uses `geom_sf()`. This geom is NOT
  # in the current version of ggplot2. It will be in the
  # next major version of ggplot2.
  
  # Get the neighborhoods.
  shp = read_sf("crime/shapefiles/ZillowNeighborhoods-CA.shp")
  names(shp) = tolower(names(shp))

  # Get San Francisco only.
  shp = shp[shp$city == "San Francisco", ]

  # Convert crime data to an 'sf' object.
  geo_df = st_as_sf(df, coords = c("x", "y"))
  st_crs(geo_df) = st_crs(shp)

  # Find neighborhood for each point.
  idx = st_within(geo_df, shp)
  idx = sapply(idx, `[`, 1)

  geo_df$regionid = shp$regionid[idx]

  # Now tabulate category by region id.
  geo_df = geo_df[df$category != "LARCENY/THEFT", ]
  top = aggregate(geo_df$category, list(geo_df$regionid), function(x) {
    names(which.max(table(x)))
  })
  names(top) = c("regionid", "category")

  shp = merge(shp, top, by = "regionid")

  ggmap(m, base_layer = ggplot(shp)) +
    geom_sf(aes(fill = category), alpha = 0.4)
}
