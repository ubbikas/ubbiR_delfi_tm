output$WordFrequencyInputUI <- renderUI({
	tagList(
    p("Controls",
      class = "boxHeader"),
    selectInput("selectModel", 
                label = "", 
                c(1,2)),
    actionButton("WordFrequencyButton",
                 label = "Display results!",
                 class = "selectionButton")
  )
})