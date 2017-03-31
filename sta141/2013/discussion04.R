# ----- 11-12 Discusion -----

# How can we map standard deviation of building square footage by county?
load('data//housing.rda')

library(maps)

# Get standard deviations by county.
sds <- tapply(housing$bsqft, housing$county, sd, na.rm = TRUE)

# Get ready to match--format the names correctly.
sds_names <- names(sds)
sds_names <- paste('california,', sds_names, sep = '')
sds_names <- substring(sds_names, 1, nchar(sds_names) - 7)
sds_names

# Match names on the standard deviations to names in the map file.
matched <- match.map('county', sds_names)

# Decide on categories and their corresponding colors.
sds_categories <- cut(sds, 4)
names(sds_categories) <- names(sds)
head(map('county', namesonly = TRUE, plot = FALSE))

palette <- heat.colors(4)
levels(sds_categories) <- palette
sds_cols <- as.character(sds_categories)

# Fill in the colors for each county.
map('county', 'california')
map('county', fill = TRUE, col = sds_cols[matched],
    add = TRUE)

# How does grouping in xyplot work?
library(lattice)

# Use | to get each group in a separate plot.
xyplot(lsqft ~ bsqft | county, housing)

# Use the groups parameter to get each group color-coded, but on one plot.
xplot(lsqft ~ bsqft, housing, groups = county)

# The groups parameter and | can be used in combination to group in two
# different ways simultaneously!

# Give an example of barplots?
data <- table(housing$county, housing$cit)
barplot(t(data), col = c('red', 'blue'))

# What's an example of using the legend function?
legend('bottomleft', legend = c('A', 'B'), col = c('red', 'blue'))

# ----- 12-1 Discussion -----

# How can we display county names on a map? How can we add an overall title
# to a series of graphs created by setting mfrow?

# Set up an example map.
a <- paste0('california,', 
            c('alameda', 'napa', 'sonoma',
              'san francisco', 'contra costa', 'marin',
              'solano', 'san mateo', 'santa clara'))

library(maps)
map('county', a)

# Use locator to locate points on the map, and text to add text at a point.
locator(1)
text(-122.9, 37.65, 'SF', cex = 0.5)
lines(c(-122.72, -122.53), c(37.66, 37.76))

# Alternatively, see ?map.text

# Adding overall title.
par(mfrow = c(3, 3), mar = rep(0, 4))
sapply(1:9, function(x) plot(1:3))

# Set xpd = NA to allow drawing anywhere on the plot.
par(xpd = NA)
text(-1.16, 7.08, 'Hello')

dev.off()

par(xpd = TRUE)
plot(1:4, 1:4, xlim = 2:3, ylim = 2:3, type = 'l',
     col = 'red')

# How can we make the x-axis show dates correctly with xyplot?
ls()
load('data//housing.rda')

library(lattice)

price_per_week <- tapply(housing$price, housing$wk,mean, na.rm = TRUE)
class(housing$wk)

# The problem is when dates have class factor:
price_wk_names <- factor(names(price_per_week))
class(price_wk_names)
xyplot(price_per_week ~ price_wk_names)

# The solution is to tell R they are actually dates:
xyplot(price_per_week ~ as.Date(as.character(price_wk_names)))

# What's an example of using the legend function?
legend('bottomleft', legend = c('B', 'A'), col = c('red', 'blue'), pch = 4)
