output$WordFrequencyPlotUI <- renderUI({
  isolate({
    tagList(
      p("Visual", 
        class = "boxHeader"),
      ggvisOutput("WordFrequencyPlotggvis")
    )
  })
})