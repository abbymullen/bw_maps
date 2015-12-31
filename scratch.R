library(leaflet)
library(sp)
library(purrr)
library(readr)
library(dplyr)
library(googlesheets)

"1-O0sCZWGkSNFK7TkzB56yD6hED_bNsplWZ1m6BjxFHE" %>%
  gs_key() %>% 
  gs_download(ws = "Master", to = "ship-movements.csv",
              overwrite = TRUE)

raw <- read_csv("ship-movements.csv")
raw <- raw %>% 
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
