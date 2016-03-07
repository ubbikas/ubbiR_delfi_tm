output$WordFrequencyPlotUI <- renderUI({
  tagList(
    p("Visual", 
      class = "boxHeader"),
    plotOutput("WordFrequencyPlot", height = "1px")
  )
})