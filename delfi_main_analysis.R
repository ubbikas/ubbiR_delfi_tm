# setting work directory
setwd(file.path(getwd(), "GitHub", "ubbiR_delfi_tm"))

source("global.R")


delfi_words_freq(c("vilnius|kaunas", "vilnius", "kaunas"))


delfi_title_assocs(c("Lietuva"), maxWords = 100)


delfi_word_of_the_year(2015, maxSum = 1, maxWords = 100)


delfi_word_change(2002, type = "appeared", maxWords = 100)
delfi_word_change(2012, type = "disappeared", maxWords = 100)



