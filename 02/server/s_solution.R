####--SERVER SOLUTION--------------------------------------------------------------------------------------------

#
# SOLU
#

####--Tab 1-------------------------------------------------------------------------------------------

output$solu_plot <- renderDygraph({
  weather_plot_f(weather_data())
})

output$solu_dt <- DT::renderDataTable({
  DT::datatable(weather_data(), 
                selection = 'single',
                style = 'bootstrap'
                )
})


####--Tab 2-------------------------------------------------------------------------------------------

output$geo_testmap <- renderLeaflet({
  leaflet() %>%
    addTiles()
})

output$pulse_icon_message <- renderText({
  v$pulse_icon_message
  })

observeEvent(input$zoom_queensland_button, {
  lat <- -20
  lng <- 146
  my_zoom <- 5
  leafletProxy("geo_testmap") %>%
    flyTo(lng, lat, zoom = my_zoom)
})

observeEvent(input$pulse_icon_button, {
  new_address <- isolate(input$pulse_icon_text)
  gcode <- geocode_OSM(new_address)
  v$pulse_icon_message <- if(is.null(gcode)) paste("Invalid address:", new_address) else ""

  validate(
    need(gcode, "Could not geo code address, try again")
  )
  
  lat <- gcode$coords[['y']]
  lng <- gcode$coords[['x']]
  my_zoom <- 12
  leafletProxy("geo_testmap") %>%
    removeControl("my_pulse_icon") %>%
    flyTo(lng, lat, zoom = my_zoom) %>%
    addPulseMarkers(
      layerId = "my_pulse_icon",
      lng = lng, lat = lat,
      label = new_address,
      icon = makePulseIcon(heartbeat = 0.5)
    )
})


