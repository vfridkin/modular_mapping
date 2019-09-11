####--SERVER------------------------------------------------------------------------------------------------

shinyServer(function(input, output, session, options = options(warn = -1)) {

####--UI BLOCK----------------------------------------------------------------------------------------------
  default_tab = "solution"
  current_version = "0.01"
  
  output$app_version <- renderUI({
    fluidRow(
      column(12, offset = 1, 
             br(),
             h5(str_c("Version ", current_version)),
             h6("Modular mapping")
             )
    )
  })
    
  output$ui_sidebar <- renderUI({
    sidebarMenu(id = "tab",
                
                menuItem("Queensland map", 
                         tabName = "solution", 
                         icon = icon("globe-asia")
                         ),
                
                # menuItem("Problem", 
                #          tabName = "problem", 
                #          icon = icon("bug")
                #          ),
                # 
                # menuItem("Data", 
                #          tabName = "data", 
                #          icon = icon("cube")
                #          ),
                
                uiOutput("app_version")
    )
  })
  
  output$ui_body <- renderUI({
    updateTabsetPanel(session, "tab", selected = "solution")
    tabItems(
      tabItem_solution,
      tabItem_problem,
      tabItem_data
    )
  })
  
####--SERVER BLOCK-----------------------------------------------------------------------------------------
  
  ## Constants
  
  ## ReactiveValues
  v <- reactiveValues(
    pulse_icon_message = "",
    map_shape_id = NULL
  )
  
  # Server modules 
  source('server/s_solution.R', local = TRUE)
  source('server/s_problem.R', local = TRUE)
  source('server/s_data.R', local = TRUE)

})  