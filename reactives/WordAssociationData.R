WordAssociationData <- eventReactive(input$WordAssociationButton, {
  progress <- shiny::Progress$new()
  on.exit(progress$close())
  progress$set(message = "Getting data..", value = 0)

  if (nchar(input$WordAssociationInput) < 1) {
    return()
  }

  input$WordAssociationInput %>%
  str_split(pattern = ",") %>%
  unlist() %>%
  str_trim(side = c("both")) %>%
  str_c(collapse = "|") -> words
  
  delfidb$pavadinimas[grepl(words, 
                            delfidb$pavadinimas, 
                            ignore.case = TRUE)] %>%
  str_c(collapse = " ") %>%
  VectorSource() %>%
  Corpus() %>%
  tm_map(content_transformer(tolower)) %>%
  tm_map(content_transformer(removePunctuation)) %>%
  tm_map(content_transformer(removeNumbers)) %>%
  tm_map(content_transformer(stripWhitespace)) %>%
  tm_map(content_transformer(function(x) gsub("„", "", x))) %>%
  tm_map(content_transformer(function(x) gsub("“", "", x))) %>%
  tm_map(content_transformer(function(x) gsub("”", "", x))) %>%
  tm_map(content_transformer(function(x) gsub("–", "", x))) %>% 
  TermDocumentMatrix() %>%
  as.matrix() %>%
  rowSums() %>%
  sort(decreasing = TRUE) -> data
  
  progress$inc(1/2, detail = paste("Calculating.."))

  data.frame(word = names(data),
             freq = data) %>%
  head(300) -> data
  
  data <- data[!grepl(words, data$word, ignore.case = TRUE), ]

  progress$inc(2/2, detail = paste("Done!"))
  
  data
})
