output$WordOfTheYearInputUI <- renderUI({
  tagList(
    p("Controls",
      class = "boxHeader"),
    p("Please choose a year for which You want to find the most
       distinct words, use first slider to select maximum number of words
       to display and second one to filter more common words."),
    selectInput("WordOfTheYearChosen",
                label = "Choose year:",
                choices = delfiYears,
                selected = 2015), 
    sliderInput("WordOfTheYearMaxWords", 
                label = "Max number of words:", 
                min = 20, 
                max = 200, 
                value = 200,
                step = 5),
    sliderInput("WordOfTheYearMaxFreqSum", 
                label = "Max frequency sum:", 
                min = 0, 
                max = 1000, 
                value = 1000,
                step = 1),
    sliderInput("WordOfTheYearTextSize", 
                label = "Wordcloud text size:", 
                min = 1, 
                max = 10, 
                value = 3,
                step = 0.5),  
    actionButton("WordOfTheYearButton",
                 label = "Display results!",
                 class = "selectionButton")    
  )
})