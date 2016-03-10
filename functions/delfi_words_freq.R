# function to find monthly frequence for given words
# - x - a vector of searchWords; if you want to include multiple words into 
#       one searchWord, separate them by '|' without whitespaces, 
#       e.g., "Vilnius|Kaunas"
delfi_words_freq <- function(searchWords, width = 600, height = 400, span = 0.1) {
  searchWords %>%
  lapply(function(x){
          delfidb[grepl(x, delfidb$pavadinimas, ignore.case = TRUE),] %>%
          group_by(ym) %>%
          summarise(Articles = n()) %>%
          mutate(Date = as.Date(ym), ID = x)
         }) %>%
  do.call(rbind, .) -> dataTable
  
  dataTable %>%
  ggvis(~Date, ~Articles) %>%
  group_by(ID) %>%
  layer_lines(stroke = ~ID, 
              strokeWidth := 2,
              opacity := 0.4) %>%
  scale_datetime("x") %>%
  layer_smooths(stroke = ~ID, 
                span = span) %>%
  set_options(width = width, 
              height = height, 
              keep_aspect = TRUE,
              resizable = FALSE,
              duration = 0,
              renderer = "canvas") -> ggvisPlot

  dataTable %>%
  group_by(ID) %>%
  summarise(AllinAll = sum(Articles)) -> dataTable

  return(list("table" = dataTable,
              "plot"  = ggvisPlot))
}