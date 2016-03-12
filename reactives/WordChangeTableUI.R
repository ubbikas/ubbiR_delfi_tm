output$WordChangeTableUI <- renderUI({
  isolate({
    tagList(
      p("Top results", 
        class = "boxHeader"),
      uiOutput("WordChangeTable")
    )
  })
})