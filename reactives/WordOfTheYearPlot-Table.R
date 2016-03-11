observe({
  req(input$WordOfTheYearButton)
  isolate({

    progress <- shiny::Progress$new()
    on.exit(progress$close())
    progress$set(message = "Getting data..", value = 0)

    progress$inc(1/4, detail = paste("Calculating.."))
    
    year <- input$WordOfTheYearChosen
    maxSum <- input$WordOfTheYearMaxFreqSum
    maxWords <- input$WordOfTheYearMaxWords
    wordCloudTextSize <- input$WordOfTheYearTextSize

    Xyear <- paste0("X", year)
    colDel <- str_c(c(Xyear, "zodis"), collapse ="|")
    
    names(delfiTdmScaled) %>%
      .[!grepl(colDel, .)] -> colForSum
    
    delfiTdmScaled %>%
      mutate_(sums =  str_c(colForSum, collapse = "+"),
              diffe = str_c(c(Xyear, "sums"), collapse = "-")) %>%
      filter(sums <= maxSum) %>%
      arrange(desc(diffe)) %>%
      select_("zodis", Xyear, "diffe", "sums") %>%
      head(maxWords) -> data

    progress$inc(2/4, detail = paste("Displaying results.."))

    # render a table top results and distinction indexes
    output$WordOfTheYearTable <- renderUI({
      words <- data %>%
               select(Word = zodis, Index = diffe) %>%
               mutate(Index = round(Index, 0)) %>%
               head(50)

      wordList <- list()
      for (i in 1:dim(words)[1]) {
        wordList[[i]] <- tags$li(words[i, "Word"], 
                                 tags$span(words[i, "Index"], 
                                           class = "badge",
                                           style = "font-size: 11px;
                                                    color: #ffffff;
                                                    background-color: #3c8dbc;"),
                                 class = "list-group-item")
      }

      return(tags$ul(wordList, 
                     class = "list-group"))
    })

    progress$inc(3/4, detail = paste("Drawing wondcloud.."))

    # render a word cloud of Word of the year results
    output$WordOfTheYearPlot <- renderPlot({
      wordcloud(words = data$zodis,
                freq = sqrt(data$diffe),
                scale = c(wordCloudTextSize, 0.1),
                min.freq = 0,
                rot.per = 0, 
                max.words = maxWords,
                random.order = FALSE,
                fixed.asp = FALSE,
                colors = brewer.pal(8, "Dark2"))
    })

    progress$inc(4/4, detail = paste("Done!"))

  })
})