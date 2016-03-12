output$WordChangeInputUI <- renderUI({
  tagList(
    p("Controls",
      class = "boxHeader"),
    p("Displays words from delfi.lt article titles which appeared
       or disappeared in a chosen year."),
    radioButtons("WordChangeType",
                 label = "Search type:",
                 choices = c("Appeared" = "appeared",
                             "Disappeared" = "disappeared")),
    selectInput("WordChangeYear",
                label = "Choose year:",
                choices = delfiYears),
    sliderInput("WordChangeMaxWords", 
                label = "Max number of words:", 
                min = 20, 
                max = 200, 
                value = 200,
                step = 5),
    sliderInput("WordChangeTextSize", 
                label = "Wordcloud text size:", 
                min = 1, 
                max = 10, 
                value = 3,
                step = 0.5),  
    actionButton("WordChangeButton",
                 label = "Display results!",
                 class = "selectionButton")    
  )
})


observe({
  req(input$WordChangeType)
  if (input$WordChangeType == "appeared") {
    updateSelectInput(session, 
                      "WordChangeYear", 
                      choices = delfiYearsAppeared,
                      selected = tail(delfiYearsAppeared, 1))
  }
  if (input$WordChangeType == "disppeared") {
    updateSelectInput(session, 
                      "WordChangeYear", 
                      choices = delfiYearsDisappeared,
                      selected = tail(delfiYearsDisappeared, 1))
  }    
})
