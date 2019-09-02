####--UI DATA--------------------------------------------------------------------------------------------

#
# DATA
# View the data and its status. 
#

tabItem_data <-
  tabItem(tabName = "data",
    fluidRow(
      column(width = 3,
             h2(icon("cube"), HTML("&nbsp;"),"Data")
             )
    ),
    tabsetPanel(
      type = "tabs",
      id = "data_tabset",
      
####--Tab 1-------------------------------------------------------------------------------------------
      tabPanel(
        'Tab 1', br()
      ),

####--Tab 1-------------------------------------------------------------------------------------------
      tabPanel(
        'Tab 2', br()
      )
    )
  )
