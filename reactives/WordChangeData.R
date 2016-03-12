WordChangeData <- eventReactive(input$WordChangeButton, {
  req(input$WordChangeType, input$WordChangeYear)

  progress <- shiny::Progress$new()
  on.exit(progress$close())
  progress$set(message = "Getting data..", value = 0)


  year <- input$WordChangeYear
  type <- input$WordChangeType

  yearNumber <- which(delfiYears == year)
  delfiYearsN <- length(delfiYears)              

  progress$inc(1/2, detail = paste("Calculating.."))

  if(type == "disappeared") {
    if (yearNumber == length(delfiYears)) {
      delfiTdmDataFrameBinary %>%
        mutate(allSums = rowSums(delfiTdmDataFrame[ , 1:delfiYearsN]),
               sums1 = rowSums(.[ ,1:delfiYearsN]),
               sums2 = rowSums(.[ ,1:(yearNumber - 1)])) %>%
        filter(sums1 == sums2) %>%
        arrange(desc(allSums)) -> data
    } else {
      delfiTdmDataFrameBinary %>%
        mutate(allSums = rowSums(delfiTdmDataFrame[ , 1:delfiYearsN]),
               sums1 = rowSums(.[ ,1:delfiYearsN]),
               sums2 = rowSums(.[ ,yearNumber:delfiYearsN])) %>%
        filter(sums1 == yearNumber - 1, sums2 == 0) %>%
        arrange(desc(allSums)) -> data
        
    }
  }

  if(type == "appeared") {
    delfiTdmDataFrameBinary %>%
      mutate(allSums = rowSums(delfiTdmDataFrame[ , 1:delfiYearsN]),
             sums1 = rowSums(.[ , 1:(yearNumber - 1)]),
             sums2 = rowSums(.[ , 1:delfiYearsN])) %>%
      filter(sums1 == 0, sums2 == delfiYearsN - (yearNumber - 1)) %>%
      arrange(desc(allSums)) -> data
  }

  data <- head(data, 300)
  
  progress$inc(2/2, detail = paste("Done!"))
  
  data
})

