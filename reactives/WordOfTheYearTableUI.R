output$WordOfTheYearTableUI <- renderUI({
  isolate({
    tagList(
      p("Top results", 
        class = "boxHeader"),
      uiOutput("WordOfTheYearTable")
    )
  })
})