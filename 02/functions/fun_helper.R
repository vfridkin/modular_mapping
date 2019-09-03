# Functions - common functions

save_and_run <- function(){
  rstudioapi::documentSaveAll()
  shiny::runApp(app_directory)
}