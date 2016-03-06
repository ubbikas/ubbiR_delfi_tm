# load libraries, set wd
source("global.R")


# load posgresql db connection
source(file.path("hidden", "DBconnection.hidden"))
# or create:
con <- dbConnect(RPostgres::Postgres(), 
                 dbname = 'DB_NAME', 
                 host = 'DB_HOST', 
                 port = 'DB_PORT', 
                 user = 'USERNAME',
                 password = 'PASSWORD')


# set system locale to Lithuanian
Sys.setlocale(, 'Lithuanian')


# crate DB table for storing information
sql_command <- "CREATE TABLE IF NOT EXISTS delfitest
                  (
                  kategorija character varying NOT NULL,
                  data date NOT NULL,
                  laikas time without time zone NOT NULL,
                  pavadinimas character varying NOT NULL,
                  linkas character varying NOT NULL,
                  straipsnis character varying
                  )
                WITH (
                  OIDS=FALSE
                );"

dbGetQuery(con, sql_command)


# read HTML of delfi archive and get number of history pages
rv <- read_html("http://www.delfi.lt/archive/?tod=01.01.2020&fromd=01.01.1999&channel=0&category=0", 
                encoding="utf-8")
HistoryPages <- rv %>% 
                html_nodes(".pagerwrapper .item") %>%
                html_text() %>%
                .[8] %>%
                as.integer


# scrape delfi archive for article titles and store them to DB
for (i in 1:HistoryPages) {
  url <- paste0("http://www.delfi.lt/archive/index.php?fromd=01.01.1999&tod=01.01.2020&channel=0&category=0&query=&page=", i)
  rv <- read_html(url, encoding="utf-8")
  
  duomenys <- data.frame(
    kategorija = rv %>% 
                 html_nodes(".search-item-head .section") %>%
                 html_text(),
    data = rv %>% 
           html_nodes(".search-item-head span") %>%
           html_text() %>%
           strsplit(" ") %>%
           unlist() %>%
           .[(1:100)*2-1] %>%
           dmy %>%
           as.Date,
    laikas = rv %>% 
             html_nodes(".search-item-head span") %>%
             html_text() %>%
             strsplit(" ") %>%
             unlist() %>%
             .[(1:100)*2],  
    pavadinimas = rv %>% 
                  html_nodes(".search-item-content .arArticleT") %>%
                  html_text() %>%
                  iconv(from="UTF-8", to = "UTF-8"),
    linkas = rv %>% 
             html_nodes(".search-item-content a:first-of-type") %>%
             html_attr("href"),
    straipsnis = c(NA),
    stringsAsFactors = FALSE
  )

  for (j in 1:dim(duomenys)[1]){
    tryCatch(dbWriteTable(con, "delfitest", 
                          value = duomenys[j, ], 
                          append = TRUE, 
                          row.names = FALSE), 
             error = function(e) print(e))
  }

  Sys.sleep(0.2)
  print(paste(round(i*100/pages, 3), "%"))
}


# disconnect from DB
dbDisconnect(con)