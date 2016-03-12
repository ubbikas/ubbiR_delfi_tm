# function to find words which appeared or disappeared in a given year
# - type: "appeared" or "disappeared"
delfi_word_change <- function(year, type = "disappeared", maxWords = 100) {
  Xyear <- paste0("X", year)

  if (!Xyear %in% colnames(delfiTdmDataFrameBinary)) {
    return(print("That year does not exists"))
  }

  if (type == "appeared") {
    if (Xyear %in% colnames(delfiTdmDataFrameBinary)[1:2]) {
      return(print("Please choose one of the later years"))
    }
  } 

  if (type == "disappeared") {
    if (Xyear %in% colnames(delfiTdmDataFrameBinary)[1]) {
      return(print("Please choose one of the later years"))
    }
  }

  yearNumber <- which(colnames(delfiTdmDataFrameBinary) == Xyear)
  
  delfiYears <- coln[grepl("X", colnames(delfiTdmDataFrameBinary))] %>%
                gsub("X", "", .) %>%
                as.numeric()
  delfiYearsN <- length(delfiYears)              


  if(type == "disappeared") {
    if (yearNumber == length(delfiYears)) {
      delfiTdmDataFrameBinary %>%
        mutate(allSums = rowSums(delfiTdmDataFrame[ , 1:delfiYearsN]),
               sums1 = rowSums(.[ ,1:delfiYearsN]),
               sums2 = rowSums(.[ ,1:(yearNumber - 1)])) %>%
        filter(sums1 == sums2) %>%
        arrange(desc(allSums)) %>%
        head(maxWords) -> data
    } else {
      delfiTdmDataFrameBinary %>%
        mutate(allSums = rowSums(delfiTdmDataFrame[ , 1:delfiYearsN]),
               sums1 = rowSums(.[ ,1:delfiYearsN]),
               sums2 = rowSums(.[ ,yearNumber:delfiYearsN])) %>%
        filter(sums1 == yearNumber - 1, sums2 == 0) %>%
        arrange(desc(allSums)) %>%
        head(maxWords) -> data
    }
  }

  if(type == "appeared") {
    delfiTdmDataFrameBinary %>%
      mutate(allSums = rowSums(delfiTdmDataFrame[ , 1:delfiYearsN]),
             sums1 = rowSums(.[ , 1:(yearNumber - 1)]),
             sums2 = rowSums(.[ , 1:delfiYearsN])) %>%
      filter(sums1 == 0, sums2 == delfiYearsN - (yearNumber - 1)) %>%
      arrange(desc(allSums)) %>%
      head(maxWords) -> data
  }
  
  print(data[, c("zodis", "allSums")])
  
  wordcloud(words = data$zodis, 
            freq = data$allSums,
            scale = c(4, 0.2),
            min.freq = 0,
            max.words = maxWords,
            random.order = FALSE, 
            rot.per = 0, 
            colors = brewer.pal(8, "Dark2"))
}