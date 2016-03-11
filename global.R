# libraries  i use
suppressPackageStartupMessages(require(dplyr))
suppressPackageStartupMessages(require(tidyr))
suppressPackageStartupMessages(require(XLConnect))
suppressPackageStartupMessages(require(shiny))
suppressPackageStartupMessages(require(shinyjs))
suppressPackageStartupMessages(require(sqldf))
suppressPackageStartupMessages(require(shinyBS))
suppressPackageStartupMessages(require(devtools))
suppressPackageStartupMessages(require(rCharts))
suppressPackageStartupMessages(require(lubridate))
suppressPackageStartupMessages(require(DT))
suppressPackageStartupMessages(require(V8))
suppressPackageStartupMessages(require(ggplot2))
suppressPackageStartupMessages(require(xml2))
suppressPackageStartupMessages(require(chron))
suppressPackageStartupMessages(require(ggvis))
suppressPackageStartupMessages(require(httr))
suppressPackageStartupMessages(require(rvest))
suppressPackageStartupMessages(require(RPostgres))
suppressPackageStartupMessages(require(DBI))
suppressPackageStartupMessages(require(scales))
suppressPackageStartupMessages(require(stringr))
suppressPackageStartupMessages(require(readr))
suppressPackageStartupMessages(require(tm))
suppressPackageStartupMessages(require(RWeka))
suppressPackageStartupMessages(require(wordcloud))
suppressPackageStartupMessages(require(beepr))
suppressPackageStartupMessages(require(shinythemes))
suppressPackageStartupMessages(require(extrafont))

# set working directory
tryCatch(setwd(file.path(getwd(), "GitHub", "ubbiR_delfi_tm")), 
         error = function(e) print("Working directory already set"))

# set system locale to Lithuanian
Sys.setlocale(, 'Lithuanian')

# load all data
source("loadData.R", local = TRUE)

# loading all custom functions
for (file in list.files("functions")) {
  source(file.path("functions", file), local = TRUE)
}