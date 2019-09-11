####--SERVER DATA--------------------------------------------------------------------------------------------

weather_data <- reactive({
  df <- predict_weather()
  validate(
    need(df, "Weather data not available")
  )
  df
})

qld_sa2_gpkg <- reactive({
  file <- "../data/census2016_eiuwi_qld_sa2_short.rds"
  readRDS(file)  
})

abs_descriptors <- reactive({
  file <- "../data/abs_descriptors.rds"
  readRDS(file)  
})