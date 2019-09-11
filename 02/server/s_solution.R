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
  
  df <- qld_sa2_gpkg()
  my_ops <- num_from_fac(df$P_AgriForestFish_Tot)/num_from_fac(df$P_Tot_Tot)
  
  leaflet() %>%
    addTiles() %>%
    addPolygons(data = df,
                weight = 1,
                color = "darkmagenta",
                fill = TRUE,
                fillColor = "darkmagenta",
                fillOpacity = my_ops,
                group = "Agriculture Employee Ratio",
                highlightOptions = highlightOptions(color = "white", 
                                                    weight = 2,
                                                    bringToFront = TRUE
                                                    ),
                popup = ~Census_Name_2016
    ) %>%
    addLayersControl(
      baseGroups = c("Hide overlays", "Agriculture Employee Ratio"),
      options = layersControlOptions(collapsed = FALSE)
    ) %>%
    hideGroup(c("Agriculture Employee Ratio")
    )
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


