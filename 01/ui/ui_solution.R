####--UI SOLUTION--------------------------------------------------------------------------------------------

#
# SOLU
#


tabItem_solution <-
  tabItem(tabName = "solution",
    fluidRow(
      column(width = 3,
             h2(icon("magic"), HTML("&nbsp;"),"Solution")
             )
    ),
    tabsetPanel(
      type = "tabs",
      id = "solution_tabset",
      
####--Weather predictions-------------------------------------------------------------------------------------------
      tabPanel(
        'Weather predictions', br(),
        dygraphOutput("solu_plot"), br(),
        fluidRow(
          box(
            title = "Weather prediction data",
            width = 12,
            collapsible = TRUE,
            collapsed = FALSE,
            status = "success",
            solidHeader = TRUE,
            dataTableOutput("solu_dt")
          )
        )
      ),

####--Geography-------------------------------------------------------------------------------------------
      tabPanel(
        'Geography', br(),
        fluidRow(
          box(
            title = NULL, width = 12, background = NULL,
            leafletOutput(outputId = "geo_testmap"),
            br()
          )
        )
      )
    )
  )
