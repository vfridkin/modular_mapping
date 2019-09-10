####--SERVER DATA--------------------------------------------------------------------------------------------

weather_data <- reactive({
  df <- predict_weather()
  validate(
    need(df, "Weather data not available")
  )
  df
})

qld_sa2_gpkg <- reactive({
  file <- "../census2016_eiuwi_qld_sa2_short.rds"
  readRDS(file)  
})
