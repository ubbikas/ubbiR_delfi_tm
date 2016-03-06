# function to find monthly frequence for given words
# - x - a vector of searchWords; if you want to include multiple words into 
#       one searchWord, separate them by '|' without whitespaces, 
#       e.g., "Vilnius|Kaunas"
delfi_words_freq <- function(searchWords) {
  searchWords %>%
  lapply(function(x){
          delfidb[grepl(x, delfidb$pavadinimas, ignore.case = TRUE),] %>%
          group_by(ym) %>%
          summarise(Articles = n()) %>%
          mutate(Date = as.Date(ym), ID = x)
         }) %>%
  do.call(rbind, .) %>%
  ggvis(~Date, ~Articles) %>%
  group_by(ID) %>%
  #layer_lines(stroke = ~ID, strokeWidth := 2) %>%
  scale_datetime("x") %>%
  layer_smooths(stroke = ~ID, span = 0.1)
}