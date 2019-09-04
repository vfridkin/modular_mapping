####--UI--------------------------------------------------------------------------------------------

#  
# The UI isn't really here but in server.R
# This allows dynamic control over UI elements
#

dashboardPage(skin = "yellow",
              dashboardHeader(title = "Modular Mapping"),
              dashboardSidebar(uiOutput("ui_sidebar")),
              dashboardBody(
                includeCSS("www/ui.css"),
                uiOutput("ui_body")
              )
)