# load libraries, set wd
source("global.R")

# load posgresql db connection..
source(file.path("hidden", "DBconnection.hidden"))
# ..or create one:
con <- dbConnect(RPostgres::Postgres(), 
                 dbname = 'DB_NAME', 
                 host = 'DB_HOST', 
                 port = 'DB_PORT', 
                 user = 'USERNAME',
                 password = 'PASSWORD')


# set system locale to Lithuanian
Sys.setlocale(, 'Lithuanian')


# make DB copy as csv file
dbReadTable(con, "delfitest") %>%
.[!duplicated(.[c("pavadinimas", "linkas")]),-c(5, 6)] %>%
write.csv("data/delfiDB.csv")


# read data directly from DB..
delfidb <- dbReadTable(con, "delfitest") %>%
           .[!duplicated(.[c("pavadinimas", "linkas")]),-c(5, 6)] %>%
           mutate(data = ymd(data),
                  valanda = hour(hms(laikas)),
                  metai = year(data),
                  menuo = month(data),
                  ym = format(data, format = "%Y-%m-01"),
                  sav_diena = wday(as.Date(data)-1),
                  savaite = format(as.Date(data)-wday(data) + 1, 
                                   format = "%Y-%m-%d"))

# ..or from csv file
delfidb <- read.csv( "delfiDB.csv") %>%
           mutate(data = ymd(data),
                  metai = year(data),
                  menuo = month(data),
                  ym = format(data, format = "%Y-%m-01"),
                  sav_diena = wday(as.Date(data)-1),
                  savaite = format(as.Date(data)-wday(data) + 1, 
                                   format = "%Y-%m-%d"))

# create data frame:
# - metai as year
# - text as all article names concatenated to one long string
by.metai <- NULL
for (metai in unique(delfidb$metai)) {
  subset <- delfidb[delfidb$metai == metai, ]
  text <- str_c(subset$pavadinimas, collapse = " ")
  row <- data.frame(metai, text, stringsAsFactors = FALSE)
  by.metai <- rbind(by.metai, row)
  print(metai)
}

# create text corpus using myReader as control mapping
myReader <- readTabular(mapping = list(content = "text", 
                                       id = "metai"))
corpus <- Corpus(DataframeSource(by.metai), 
                 readerControl = list(reader = myReader))

# transform corpus:
# - change all letters to lowercase
# - remove punctuation
# - remove lithuanian punctuation
# - remove numbers
# - strip whitespaces
corpus %>%
tm_map(content_transformer(tolower)) %>%
tm_map(content_transformer(removePunctuation)) %>%
tm_map(content_transformer(function(x) gsub("„", "", x))) %>%
tm_map(content_transformer(function(x) gsub("“", "", x))) %>%
tm_map(content_transformer(function(x) gsub("”", "", x))) %>%
tm_map(content_transformer(function(x) gsub("–", "", x))) %>% 
tm_map(content_transformer(removeNumbers)) %>%
tm_map(content_transformer(stripWhitespace)) -> corpus

# save transformed corpus as R data file
saveRDS(corpus, "data/corpus.rds")


# if RAM size is enough, corpus word tokens can be created and transformed to 
# term document matrix
allTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 2))
delfi.tdm <- TermDocumentMatrix(corpus, control = list(tokenize = allTokenizer))

# .. or transformed to term document matrix withour tokens
delfi.tdm <- TermDocumentMatrix(corpus) 

# sparse terms can be removed
delfi.tdm.01 <- removeSparseTerms(delfi.tdm, 0.1)

# save final term document matrix as R data file
saveRDS(delfi.tdm, "data/delfiTdm.rds")

# create data frame from TDM object and save to csv file
delfiTdmDataFrame <- data.frame(inspect(delfi.tdm))
delfiTdmDataFrame$zodis <- row.names(delfiTdmDataFrame)
write.csv(delfiTdmDataFrame, "data/delfiTDMdf.csv", row.names = FALSE)