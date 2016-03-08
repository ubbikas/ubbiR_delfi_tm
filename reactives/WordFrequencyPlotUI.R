output$WordFrequencyPlotUI <- renderUI({
  isolate({
    tagList(
      p("Visual", 
        class = "boxHeader"),
      plotOutput("WordFrequencyPlotggvisSize", height = "1px"),
      ggvisOutput("WordFrequencyPlotggvis")
    )
  })
})