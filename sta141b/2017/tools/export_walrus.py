#!/usr/bin/env python2
#
# Extract the walrus habitat shapefile from the marine mammal IUCN data
# available at:
#
#     http://www.iucnredlist.org/technical-documents/spatial-data
#

import geopandas as gpd

mammals = gpd.read_file("mammals/MARINE_MAMMALS.shp")
mammals = mammals[mammals.scientific == "Odobenus rosmarus"]
mammals.to_file("walrus.geojson", driver = "GeoJSON")
