# 2017 SFPD Crime Reports
#
# Crime Report CSV file from SF Open Data:
#   https://data.sfgov.org/Public-Safety/Police-Department-Incidents/tmnf-yvry
#
# Or you can use the RDS file available on Canvas.
#
# Shapefile from Zillow:
#   https://www.zillowstatic.com/static/shp/ZillowNeighborhoods-CA.zip

library(lubridate)
library(readr)
library(ggmap)

# 1. Clean up the data set.
clean_data = function(path = "crime/sfpd_incidents.csv") {
  df = read_csv(path)
  names(df) = tolower(names(df))
  
  # Transform columns ...
  df$date = mdy(df$date)
  df = df[year(df$date) == 2017, ]
  
  df$category = factor(df$category)
  
  saveRDS(df, "sfpd_incidents.rds")
  
  df
}

data_analysis = function() {
  df = readRDS("sfpd_incidents.rds")
# ----------------------------------------
# 2. When do most crimes take place?
  freq = table(hour(df$time))
  freq = as.data.frame(freq)
  names(freq) = c("hour", "freq")
  
  ggplot(freq, aes(hour)) + geom_bar()
  
  ggplot(df, aes(hour(time))) + geom_bar()
  
  freq = table(df$category, hour(df$time))
  freq = as.data.frame(freq)
  names(freq) = c("category", "hour", "freq")

  ggplot(freq, aes(hour, category, fill = freq)) + geom_tile()

# ----------------------------------------
# 3. Where do most crimes take place?
  loc = sapply(df[c("x", "y")], function(x) mean(range(x)))
  m = get_map(loc, zoom = 12)
  
  ggmap(m) + geom_density_2d(aes(x, y), df)
  
  ggmap(m)

# ----------------------------------------
# 4. What kinds of crimes occur in each neighborhood?
#
# NOTE: This example uses `geom_sf()`. This geom is NOT
# in the current version of ggplot2. It will be in the
# next major version of ggplot2.
}