####--UI PROBLEM--------------------------------------------------------------------------------------------

#
# PROB
#

tabItem_problem <-
  tabItem(tabName = "problem",
    fluidRow(
      column(width = 3,
             h2(icon("bug"), HTML("&nbsp;"),"Problem")
             ),
      column(width = 6),
      column(width = 3,
             box(
               title = "Version 0.01", width = 12, background = "light-blue",
               "Another heading"
             )
      )
    ),
    tabsetPanel(
      type = "tabs",
      id = "prob_tabset",
      
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
