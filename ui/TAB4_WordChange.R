# TAB 4 - displays words from delfi.lt article titles which appeared 
#         or disappeared in a chosen year
output$TAB4 <- renderUI({
  list(
    fluidRow(
      column(2, class = "box",
        uiOutput("WordChangeInputUI")
      ),
      column(7, class = "box",
        uiOutput("WordChangePlotUI")
      ),
      column(2, class = "box",
        uiOutput("WordChangeTableUI")
      )
    )
  )
})