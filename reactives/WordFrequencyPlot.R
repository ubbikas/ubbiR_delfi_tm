observe({
  req(input$WordFrequencyButton)
  isolate({
    searchWords <- c()
    searchWordsID <- c()
    
    progress <- shiny::Progress$new()
    on.exit(progress$close())
    progress$set(message = "Getting data..", value = 0)
    
    for (i in 1:3) {
      if (input[[paste0("WordFrequencyInput", i)]] != "") {
        searchWords <- c(searchWords, 
                         input[[paste0("WordFrequencyInput", i)]])
        searchWordsID <- c(searchWordsID, i)
      }
    }

    if (length(searchWords) == 0) return()

    delfi_words_freq(searchWords = searchWords,
                     height = 380,
                     span = input$WordFrequencySpanInput) -> delfi_words_freq_data
    
    progress$inc(1/3, detail = paste("Calculating.."))

    for (i in 1:3) {
      closeAlert(session,
                 alertId = paste0("WordFrequencyInputCount", i, "ID")
      )
    }

    for (i in searchWordsID) {
      word <- input[[paste0("WordFrequencyInput", i)]]

      count <- delfi_words_freq_data[["table"]] %>% 
               filter(ID == word) %>%
               .[ , 2] %>%
               unlist()
      
      if (length(count) == 0) count <- 0

      createAlert(session,
                  paste0("WordFrequencyInputCount", i),
                  alertId = paste0("WordFrequencyInputCount", i, "ID"),
                  content = paste("Found", count, "articles"),
                  style = "info",
                  append = FALSE)
    }

    progress$inc(2/3, detail = paste("Plotting.."))

    delfi_words_freq_data[["plot"]] %>%
    bind_shiny("WordFrequencyPlotggvis")

    progress$inc(3/3, detail = paste("Done!"))

  })  
})

