# TAB 2 - displays the most distinct words of a chosen year
output$TAB2 <- renderUI({
  list(
    fluidRow(
      column(2, class = "box",
        uiOutput("WordOfTheYearInputUI")
      ),
      column(7, class = "box",
        uiOutput("WordOfTheYearPlotUI")
      ),
      column(2, class = "box",
        uiOutput("WordOfTheYearTableUI")
      )
    )
  )
})