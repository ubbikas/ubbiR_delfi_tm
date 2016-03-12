output$WordChangePlotUI <- renderUI({
  isolate({
    tagList(
      p("Visual", 
        class = "boxHeader"),
      plotOutput("WordChangePlot")
    )
  })
})