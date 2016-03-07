output$WordFrequencyTableUI <- renderUI({
  tagList(
    p("Table", 
      class = "boxHeader"),
    renderTable("WordFrequencyTable")
  )
})