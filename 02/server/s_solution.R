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

