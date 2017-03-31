# A short script to create the quakes_subset.rds file.

# Load the data.
load('quakes.rda')

# Remove NAs. This isn't always the best strategy!
quakes = na.omit(quakes)

# Subset to only a few locations.
locations = c("JAPAN", "NORTHERN CALIFORNIA",
              "CENTRAL CALIFORNIA", "SOUTHERN CALIFORNIA")
quakes = subset(quakes, location %in% locations)
quakes$location = factor(quakes$location)

# Save as an RDS file.
saveRDS(quakes, 'quakes_subset.rds')
