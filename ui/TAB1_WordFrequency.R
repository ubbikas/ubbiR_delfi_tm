# TAB 1 - displays monthly frequency of chosen words 
output$TAB1 <- renderUI({
  list(
    fluidRow(
      column(2, class = "box",
        uiOutput("WordFrequencyInputUI")
      ),
      column(7, class = "box",
        uiOutput("WordFrequencyPlotUI")
      )
    )
  )
})


