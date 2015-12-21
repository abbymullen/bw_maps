library(leaflet)
library(sp)
library(purrr)
library(readr)
library(dplyr)

raw <- read_csv("Ship_movements_Master.csv")
raw <- raw[,1:4] %>% 
  filter(!is.na(long),
         !is.na(lat))

get_lines <- function(x) {
  x %>% 
    select(long, lat) %>% 
    as.matrix() %>% 
    Line() %>% 
    list() %>% 
    Lines(ID = "a") %>% 
    list() %>% 
    SpatialLines()
}

l <- raw %>% 
  split(.$ship) %>% 
  map(get_lines)

leaflet() %>% 
  addTiles() %>% 
  addPolylines(data = l[[1]])
