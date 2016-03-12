# render a word cloud of word associations
output$WordAssociationPlot <- renderPlot({
  req(WordAssociationData())

  data <- WordAssociationData()
  wordCloudTextSize <- input$WordAssociationTextSize
  maxWords <- input$WordAssociationMaxWords

  wordcloud(words = data$word,
            freq = sqrt(data$freq),
            scale = c(wordCloudTextSize, 0.1),
            min.freq = 0,
            rot.per = 0, 
            max.words = maxWords,
            random.order = FALSE,
            fixed.asp = FALSE,
            colors = brewer.pal(8, "Dark2"))

})