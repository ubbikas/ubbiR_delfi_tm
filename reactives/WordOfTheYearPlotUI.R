output$WordOfTheYearPlotUI <- renderUI({
  isolate({
    tagList(
      p("Visual", 
        class = "boxHeader"),
      plotOutput("WordOfTheYearPlot")
    )
  })
})