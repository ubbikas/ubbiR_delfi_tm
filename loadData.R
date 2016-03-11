loaded_objects <- ls()

print("Loading data..")
loadingProgress <- txtProgressBar(min = 0, max = 8, style = 3)

# load all DB data from csv file and create variables of 
# different time periods
if (!"delfidb" %in% loaded_objects) {
  delfidb <- read.csv("data/delfiDB.csv", stringsAsFactors = FALSE) %>%
           mutate(data = ymd(data),
                  metai = year(data),
                  menuo = month(data),
                  ym = format(data, format = "%Y-%m-01"),
                  sav_diena = wday(as.Date(data) - 1),
                  savaite = format(as.Date(data) - wday(data) + 1, format = "%Y-%m-%d")) %>%
           filter(metai != 2016)
}
setTxtProgressBar(loadingProgress, 1)

# load term document matrix
if (!"delfi.tdm" %in% loaded_objects) {
  delfi.tdm <- readRDS("data/delfiTdm.rds")
}
setTxtProgressBar(loadingProgress, 2)

# load term document matrix as data frame
if (!"delfiTdmDataFrame" %in% loaded_objects) {
  delfiTdmDataFrame <- read.csv("data/delfiTDMdf.csv", stringsAsFactors = FALSE) %>%
                       select(X2000, X2001, X2002, X2003, X2004, X2005, 
                              X2006, X2007, X2008, X2009, X2010, X2011, 
                              X2012, X2013, X2014, X2015, zodis)
}
setTxtProgressBar(loadingProgress, 3)

# create a scale for normalizing yearly data by article sum that year
if (!"yearlyScale" %in% loaded_objects) {
  yearlyScale <- scale(colSums(delfiTdmDataFrame[ , 1:16]), center = FALSE)
}
setTxtProgressBar(loadingProgress, 4)

# normalize TDM data frame
if (!"delfiTdmScaled" %in% loaded_objects) {
  delfiTdmScaled <- data.frame(mapply(`/`, delfiTdmDataFrame[ , 1:16], yearlyScale),
                               zodis = delfiTdmDataFrame$zodis)
}
setTxtProgressBar(loadingProgress, 5)

# create TDM data frame without words
if (!"delfiTdmDataFrameNum" %in% loaded_objects) {
  delfiTdmDataFrameNum <- delfiTdmDataFrame %>%
    select(X2000, X2001, X2002, X2003, X2004, X2005, 
           X2006, X2007, X2008, X2009, X2010, X2011, 
           X2012, X2013, X2014, X2015)
}
setTxtProgressBar(loadingProgress, 6)

# make binary data frame - if words exist that year - it's given a 1, else - 0;
# place words back to TDM data frame
if (!"delfiTdmDataFrameBinary" %in% loaded_objects) {
  delfiTdmDataFrameBinary <- data.frame(ifelse(delfiTdmDataFrameNum == 0, 0, 1))
  delfiTdmDataFrameBinary$zodis <- delfiTdmDataFrame$zodis
}
setTxtProgressBar(loadingProgress, 7)

# make binary data frame - if words exist that year - it's given a 1, else - 0;
# place words back to TDM data frame
if (!"delfiYears" %in% loaded_objects) {
  coln <- colnames(delfiTdmDataFrameBinary)
  delfiYears <- coln[grepl("X", coln)] %>%
                gsub("X", "", .) %>%
                as.numeric()
}
setTxtProgressBar(loadingProgress, 8)

close(loadingProgress)
