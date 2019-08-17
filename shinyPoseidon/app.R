library(shiny)
library(lubridate)
library(akima)
library(colorspace)
library(tidyr)
library(ggplot2)
library(data.table)

ysi <- readRDS("data/ysi.rds")
ysi$neg.depth <- -1 * ysi$depth.m
ysi.DT <- as.data.table(ysi)

secchi <- readRDS("data/secchi.rds")
secchi <- separate(data = secchi, col = sample.date, into = c("Year", "Month", "Day"), remove = FALSE)
secchi$neg.depth <- -1 * secchi$secchi.depth.m
secchi$yday <- yday(secchi$sample.date)

date.options <- as.character(unique(ysi$sample.date))
year.options <- as.character(unique(year(ysi$sample.date)))




source('ui-poseidon.R')
source('server-poseidon.R', local = TRUE)


shinyApp(ui=ui, server=server)