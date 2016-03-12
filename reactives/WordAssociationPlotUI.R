output$WordAssociationPlotUI <- renderUI({
  isolate({
    tagList(
      p("Visual", 
        class = "boxHeader"),
      plotOutput("WordAssociationPlot")
    )
  })
})