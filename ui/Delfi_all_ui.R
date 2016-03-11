output$Delfi_all_ui <- renderUI({
  navbarPage("Analysis of delfi.lt article titles", 
    inverse = TRUE,
    id = "top",
    tabPanel("Word frequency", uiOutput("TAB1")),
    tabPanel("Word of the year", uiOutput("TAB2")),
    tabPanel("Word associations", uiOutput("TAB3")),
    tabPanel("Word yearly changes", uiOutput("TAB4"))
  )
})