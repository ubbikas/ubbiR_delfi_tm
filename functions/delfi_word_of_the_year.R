# function to find most used word of the year, keeping sum of words 
# appearing frequency in other year as maxSum so you can filter commonly
# used words
delfi_word_of_the_year <- function(year, maxSum = 10000, maxWords = 100) {
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
  
  print(data)
  
  wordcloud(words = data$zodis,
            freq = data$diffe,
            scale = c(4, 0.2),
            min.freq = 0,
            max.words = maxWords,
            random.order = FALSE, 
            rot.per = 0, 
            colors = brewer.pal(8, "Dark2"),
            res = 700)
}