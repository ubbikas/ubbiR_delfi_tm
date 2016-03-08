output$WordFrequencyInputUI <- renderUI({
  tagList(
    p("Controls",
      class = "boxHeader"),
    textInput("WordFrequencyInput1", 
              label = "To display monthly frequencies of words or phrases 
                       appearing in delfi.lt article titles, insert up to 3 of them. 
                       If You want to account for any of multiple inserts to be found, 
                       separate them by '|' symbol"),
    textInput("WordFrequencyInput2", 
              label = ""),
    textInput("WordFrequencyInput3", 
              label = ""),                  
    actionButton("WordFrequencyButton",
                 label = "Display results!",
                 class = "selectionButton")
  )
})