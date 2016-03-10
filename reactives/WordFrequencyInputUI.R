output$WordFrequencyInputUI <- renderUI({
  tagList(
    p("Controls",
      class = "boxHeader"),
    p("To display monthly frequencies of words or phrases 
       appearing in delfi.lt article titles, insert up to 3 of them. 
       If You want to account for any of multiple inserts to be found, 
       separate them by '|' symbol."),
    textInput("WordFrequencyInput1", 
              label = ""),
    bsAlert("WordFrequencyInputCount1"),
    textInput("WordFrequencyInput2", 
              label = ""),
    bsAlert("WordFrequencyInputCount2"),
    textInput("WordFrequencyInput3", 
              label = ""),
    bsAlert("WordFrequencyInputCount3"),
    sliderInput("WordFrequencySpanInput", "Smoothing:", 
                min = 0.08, 
                max = 1, 
                value = 0.1, 
                step = 0.02),
    actionButton("WordFrequencyButton",
                 label = "Display results!",
                 class = "selectionButton")    
  )
})