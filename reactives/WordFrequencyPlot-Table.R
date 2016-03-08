observe({
  req(input$WordFrequencyButton)
  session$clientData$output_WordFrequencyPlotggvisSize_width
  isolate({
    searchWords <- c()

    for (i in 1:3) {
      if (input[[paste0("WordFrequencyInput", i)]] != "") {
        searchWords <- c(searchWords, 
                         input[[paste0("WordFrequencyInput", i)]])
      }
    }

    if (length(searchWords) == 0) return()

    delfi_words_freq(searchWords = searchWords, 
                     width = session$clientData$output_WordFrequencyPlotggvisSize_width,
                     height = 380)-> delfi_words_freq_data

    delfi_words_freq_data[["plot"]] %>%
    bind_shiny("WordFrequencyPlotggvis")

    output$WordFrequencyTable <- renderTable({
      delfi_words_freq_data[["table"]] %>%
      data.frame()
    })

  })  
})

