library(forecast)
library(tidyverse)
library(TSstudio)
library(xts)
library(lubridate)
library(TTR)


# Forecasting
# reading the data
bitcoin <- read.csv("/Users/johnhope/Desktop/2021 Skills Challenge/BitcoinHistoricalData.csv")

# changing date column to date object
bitcoin$Date <- as.Date(bitcoin$Date, "%m/%d/%y")

# removing commas and making price numeric
bitcoin$Price <- as.numeric(gsub(",","",bitcoin$Price))

# making time series object
bit.xts <- xts(bitcoin$Price, bitcoin$Date)

# plotting initial graph
plot(bit.xts, 
     ylim = c(0,65000), 
     xlim=c("2010-7-18","2023-10-17"), 
     main = "Bitcoin", 
     col = 'red')

# Subsetting data from July 2018 on
bitcoin <- bitcoin[1:(1935-730),]
bit.xts <- xts(bitcoin$Price, bitcoin$Date)

# Making objecr ts() instead of xts(), to work with forecasting
bit.ts <- ts(bit.xts, start=c(2018,7), frequency = 365)

# Creating and plotting the forecast
bit.ts %>%
  forecast(h=730, level = 80) %>% 
  plot(ylim = c(0,130000), 
       main = "Bitcoin Forecasts", 
       xlab = "Time",
       ylab = "Price")


# Sentiment Analysis

library(tm)
library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(wordcloud)

# Reading data
tweets <- vroom::vroom("/Users/johnhope/Desktop/2021 Skills Challenge/BitcoinTweets.csv")
set.seed(2021) #replicabiility
tweets <- sample_n(tweets, 10000) #sampling tweets for simplicity

# Creating the tweet corpus
tweetCorpus <- iconv(tweets$text)
tweetCorpus <- Corpus(VectorSource(tweetCorpus))
tweetCorpus <- tm_map(tweetCorpus, tolower) #change to all lowercase
tweetCorpus <- tm_map(tweetCorpus, removePunctuation) #removing puncuation
tweetCorpus <- tm_map(tweetCorpus, removeNumbers) #removing numbers
cleanSet <- tm_map(tweetCorpus, removeWords, stopwords('english')) #removing stop words
remove <- function(x) gsub('http[[:alnum:]]*', '', x) #removing URLs function
cleanedTweets <- tm_map(cleanSet, content_transformer(remove))  #removing URLs

tweet_matrix <- TermDocumentMatrix(cleanedTweets) #term document matrix seperates words
tweet_matrix <- as.matrix(tweet_matrix) # making it a matrix object

tweet_nrc <- get_nrc_sentiment(iconv(tweets$text)) #accessing nrc sentiment

# Graphing nrc
barplot(colSums(sentiment),
        las = 2,
        col = rainbow(15),
        ylab = 'Count',
        main = 'Sentiments of Bitcoin Tweets')


# Word cloud
w <- sort(rowSums(tweet_matrix), decreasing = TRUE)
set.seed(2021) #replicability
wordcloud(words = names(w),
          freq = w,
          max.words = 100,
          random.order = F,
          min.freq = 5,
          colors = brewer.pal(8, 'Set1'),
          scale = c(10, 0.3),
          rot.per = 0.7)


