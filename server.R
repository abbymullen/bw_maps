library("shiny")
library("leaflet")
suppressMessages(library(dplyr))

shinyServer(function(input, output, session) {

  ship_selected <- reactive({
    
    if (input$selected_ship == "All ships") {
      selected <- ships 
    } else {
      selected <- ships %>% 
        filter(ship == input$selected_ship)
    }
    
    selected %>% 
      arrange(date) %>% 
      filter(date <= input$display_date) %>% 
      group_by(ship) %>% 
      slice(n()) 
    
  })

  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles(options = tileOptions(minZoom = 3)) %>%
      setView(lat = 40, lng = 4, zoom = 5) %>% 
      addLegend("bottomright", pal = ship_colors, values = ships$ship,
                title = "Ships")
  })

  observe({
    selected <- ship_selected()

    leafletProxy("map", data = selected) %>%
      clearMarkers() %>%
      clearPopups()

    if (nrow(selected) > 0) {
      leafletProxy("map", data = selected) %>%
      addCircleMarkers(layerId = ~ship, lng = ~long, lat = ~lat,
      color = ~ship_colors(ship), 
      popup = ~paste(ship, '\n', "Lat: ", lat, '\n', "Lon:", long),
      fillOpacity = 0.4, weight = 2)
    }

    # if (nrow(df) == 1) {
    #   leafletProxy("map", data = df) %>%
    #     addPopups(~lon, ~lat, ~location, layerId = ~location)
    # }

  })

  # If the reset button is clicked, show all cities and years
  observeEvent(input$reset_button, {
    updateSelectInput(session, "city_select", selected = "All cities")
    updateSliderInput(session, "year_published", value = year_range)
  })

})
