library(leaflet)
ships <- readRDS("ship_data.rds")
date_range <- range(ships$date)
ship_names <- c("All ships", sort(unique(ships$ship)))
num_colors <- length(ship_names) - 1
ship_colors <- colorFactor(topo.colors(num_colors), factor(ships$ship))
