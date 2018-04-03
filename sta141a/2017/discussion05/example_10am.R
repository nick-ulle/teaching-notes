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
library(lubridate)
library(readr)

# 1. Clean up the data set.
clean_data = function(path = "crime/sfpd_incidents.csv",
  output = "sfpd_incidents.rds"
) {
  df = read_csv(path)
  names(df) = tolower(names(df))
  
  # Transforming variables and subsetting...
  df$date = mdy(df$date)
  df = df[year(df$date) == "2017", ]
  
  df$category = factor(df$category)
  # ...
  
  saveRDS(df, output)
  
  df
}

analyze_data = function() {
  df = readRDS("sfpd_incidents.rds")
  
# ----------------------------------------
# 2. When do most crimes take place?
  freq = table(df$category, hour(df$time))
  freq = as.data.frame(freq)
  names(freq) = c("category", "hour", "freq")
  
  gg = ggplot(freq, aes(hour, category, fill = freq))
  gg + geom_tile()

# ----------------------------------------
# 3. Where do most crimes take place?
  loc = sapply(df[c("x", "y")], median)
  loc = c(median(df$x), median(df$y))
  m = get_map(loc, zoom = 12)

  ggmap(m) + geom_density_2d(aes(x, y), df)

# ----------------------------------------
# 4. What kinds of crimes occur in each neighborhood?
#
# NOTE: This example uses `geom_sf()`. This geom is NOT
# in the current version of ggplot2. It will be in the
# next major version of ggplot2.
}