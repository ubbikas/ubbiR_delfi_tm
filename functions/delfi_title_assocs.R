# function to find words in article titles, most frequently appearing together 
# with seachWords
# - seachWords - a vector of words to associate to
# - maxWords - a maximum number of associations
delfi_title_assocs <- function(seachWords, maxWords = 100) {
  seachWords %>%
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
  
  data.frame(word = names(data),
             freq = data) %>%
  head(maxWords) -> data
  
  data <- data[!grepl(words, data$word, ignore.case = TRUE), ]
  
  print(data)
  
  wordcloud(words = data$word, 
            freq = data$freq,
            scale = c(4, 0.2),
            min.freq = 0,
            max.words = 100, 
            random.order = FALSE, 
            rot.per = 0, 
            colors = brewer.pal(8, "Dark2"))
}