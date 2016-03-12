# render a table of top word change results and counts
output$WordChangeTable <- renderUI({
  req(WordChangeData())

  words <- WordChangeData() %>%
           head(50) %>%
           select(Word = zodis, Count = allSums) %>%
           mutate(Count = round(Count, 0))

  wordList <- list()
  for (i in 1:dim(words)[1]) {
    wordList[[i]] <- tags$li(words[i, "Word"], 
                             tags$span(words[i, "Count"], 
                                       class = "badge",
                                       style = "font-size: 11px;
                                                color: #ffffff;
                                                background-color: #3c8dbc;"),
                             class = "list-group-item")
  }

  return(tags$ul(wordList, 
                 class = "list-group"))
})