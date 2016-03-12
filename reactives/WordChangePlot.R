# render a word cloud of word change
output$WordChangePlot <- renderPlot({

  data <- WordChangeData()
  wordCloudTextSize <- input$WordChangeTextSize
  maxWords <- input$WordChangeMaxWords

  wordcloud(words = data$zodis,
            freq = sqrt(data$allSums),
            scale = c(wordCloudTextSize, 0.1),
            min.freq = 0,
            rot.per = 0, 
            max.words = maxWords,
            random.order = FALSE,
            fixed.asp = FALSE,
            colors = brewer.pal(8, "Dark2"))

})