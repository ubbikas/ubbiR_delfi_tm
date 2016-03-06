# load all DB data from csv file and create variables of 
# different time periods
delfidb <- read.csv("data/delfiDB.csv", stringsAsFactors = FALSE) %>%
           mutate(data = ymd(data),
                  metai = year(data),
                  menuo = month(data),
                  ym = format(data, format = "%Y-%m-01"),
                  sav_diena = wday(as.Date(data) - 1),
                  savaite = format(as.Date(data) - wday(data) + 1, format = "%Y-%m-%d")) %>%
           filter(metai != 2016)

# load term document matrix
delfi.tdm <- readRDS("data/delfiTdm.rds")

# load term document matrix as data frame
delfiTdmDataFrame <- read.csv("data/delfiTDMdf.csv", stringsAsFactors = FALSE)  

# sort DF columns
delfiTdmDataFrame <- delfiTdmDataFrame %>%
                     select(X2000, X2001, X2002, X2003, X2004, X2005, 
                            X2006, X2007, X2008, X2009, X2010, X2011, 
                            X2012, X2013, X2014, X2015, zodis)

# create a scale for normalizing yearly data by article sum that year
yearlyScale <- scale(colSums(delfiTdmDataFrame[ , 1:16]), center = FALSE)

# normalize TDM data frame
delfiTdmScaled <- data.frame(mapply(`/`, delfiTdmDataFrame[ , 1:16], yearlyScale),
                             zodis = delfiTdmDataFrame$zodis)    

# create TDM data frame without words
delfiTdmDataFrameNum <- delfiTdmDataFrame %>%
  select(X2000, X2001, X2002, X2003, X2004, X2005, 
         X2006, X2007, X2008, X2009, X2010, X2011, 
         X2012, X2013, X2014, X2015)

# make binary data frame - if words exist that year - it's given a 1, else - 0
delfiTdmDataFrameBinary <- data.frame(ifelse(delfiTdmDataFrameNum == 0, 0, 1))

# place words back to TDM data frame
delfiTdmDataFrameBinary$zodis <- delfiTdmDataFrame$zodis
