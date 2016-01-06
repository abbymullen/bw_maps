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

saveRDS(raw, file = "ship_data.rds")
