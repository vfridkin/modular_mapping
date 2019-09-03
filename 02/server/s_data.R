####--SERVER DATA--------------------------------------------------------------------------------------------

weather_data <- reactive({
  df <- predict_weather()
  validate(
    need(df, "Weather data not available")
  )
  df
})
