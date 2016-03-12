output$WordAssociationTableUI <- renderUI({
  isolate({
    tagList(
      p("Top results", 
        class = "boxHeader"),
      uiOutput("WordAssociationTable")
    )
  })
})