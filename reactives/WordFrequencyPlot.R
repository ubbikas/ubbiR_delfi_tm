observe({
  req(input$WordFrequencyButton)
  session$clientData$output_WordFrequencyPlotggvisSize_width
  isolate({
    searchWords <- c()
    searchWordsID <- c()

    for (i in 1:3) {
      if (input[[paste0("WordFrequencyInput", i)]] != "") {
        searchWords <- c(searchWords, 
                         input[[paste0("WordFrequencyInput", i)]])
        searchWordsID <- c(searchWordsID, i)
      }
    }

    if (length(searchWords) == 0) return()

    delfi_words_freq(searchWords = searchWords, 
                     width = session$clientData$output_WordFrequencyPlotggvisSize_width,
                     height = 380,
                     span = input$WordFrequencySpanInput) -> delfi_words_freq_data

    delfi_words_freq_data[["plot"]] %>%
    bind_shiny("WordFrequencyPlotggvis")

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

  })  
})

