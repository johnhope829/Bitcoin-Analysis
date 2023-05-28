# Bitcoin-Analysis
This repository contains the materials from a personal project of mine studying different trends within the cryptocurrency market, specifically at Bitcoin.

## Data

There are 4 data files in this repository, which can be found in the data folder. The files '2020AdoptionIndex.csv' and '2021AdoptionIndex.csv' contain information on cryptocurrency adoption metrics for between 155 and 158 countries, and the data was collected using web scraping techniques. The file 'BitcoinHistoricalData.csv' contains daily historical values of Bitcoin in USD, as well as trading volumes, and was found in a publicly accessible dataset. The file 'BitcoinTweets.csv' contains tweets discussing Bitcoin, and was collected using the Twitter API and Python.

## Methods

The two files in the 'src' folder contain the actual analysis of this project. The file 'ForecastingAndSentimentAnalysis.r' is an R script that utilizes time series analysis and forecasting to study current future Bitcoin valuations, as well as conducting NLP to understand the current public sentiment behind Bitcoin. The file 'GeographicTrends.twb' is a Tableau workbook visualizaing the geographic cryptocurrency adoption trends.

## Figures

The figures contained in the 'figures' folder are visualizations created from the two files discussed in the above section. These visualization represent the findings of the current and future trends being studied in this project.
