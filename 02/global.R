####--GLOBAL--------------------------------------------------------------------------------------------

#  
# This file loads automatically before ui.R and server.R 
# Load packages and source files used in the app 
#

my_packages <- c('tidyverse',
                 'shinycssloaders', 'shinydashboard', 'shinyjs', 'shinyWidgets', 
                 'DT', 'dygraphs', 'gridExtra', 'RColorBrewer', 'summarytools', 
                 'leaflet', 'leaflet.extras', 'tmaptools',
                 'tibbletime', 'data.table', 
                 'broom', 'purrr', 'scales', 'lubridate', 'janitor',    
                 'readxl', 'glue')
invisible(lapply(my_packages, library, character.only = TRUE))

# Global constants

app_directory <- '02'

# Make sure to source function and ui files here or they won't be used by the app
# Source server files within server.R 

source('functions/fun_features.R')
source('functions/fun_mutate.R')
source('functions/fun_helper.R')
source('functions/fun_io.R')
source('functions/fun_plots.R')
source('functions/fun_sql.R')

source('ui/ui_solution.R')
source('ui/ui_problem.R')
source('ui/ui_data.R')