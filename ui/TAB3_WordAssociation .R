# TAB 3 - displays words most commonly appearing with searchword 
#         in delfi.lt article titles
output$TAB3 <- renderUI({
  list(
    fluidRow(
      column(2, class = "box",
        uiOutput("WordAssociationInputUI")
      ),
      column(7, class = "box",
        uiOutput("WordAssociationPlotUI")
      ),
      column(2, class = "box",
        uiOutput("WordAssociationTableUI")
      )
    )
  )
})