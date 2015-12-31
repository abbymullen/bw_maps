library("shiny")
library("leaflet")

shinyUI(
  fluidPage(
    tags$head(tags$link(rel = "stylesheet", type = "text/css",
                        href = "custom.css")),
    headerPanel("Ship Movements in the Mediterranean"),
    sidebarLayout(
      sidebarPanel(
        sliderInput("display_date", "Date",
                    min = date_range[1], max = date_range[2], 
                    value = date_range[1]),
                    # sep = "", round = TRUE, step = 1),
        selectInput("selected_ship", "Ship", ship_names),
        actionButton("reset_button", "All cities & years",
                     icon = icon("repeat"), class = "btn-warning btn-sm"),
        includeHTML("explanation.html"),
        width = 3
      ),
      mainPanel(
        leafletOutput("map", width = "100%", height = "600px")
      )
    )
  )
)
