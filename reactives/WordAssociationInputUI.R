output$WordAssociationInputUI <- renderUI({
  tagList(
    p("Controls",
      class = "boxHeader"),
    p("Search for words which are appearing together in article titles
       with your searchword. Insert words or phrases separated by commas for
       generating a multiple word search."),
    textInput("WordAssociationInput", 
              label = "Seach words:"),
    sliderInput("WordAssociationMaxWords",
                label = "Max number of words:", 
                min = 20, 
                max = 200, 
                value = 200,
                step = 5),
    sliderInput("WordAssociationTextSize", 
                label = "Wordcloud text size:", 
                min = 1, 
                max = 10, 
                value = 3,
                step = 0.5),      
    actionButton("WordAssociationButton",
                 label = "Display results!",
                 class = "selectionButton")    
  )
})