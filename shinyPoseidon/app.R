library(shiny)
library(lubridate)
library(akima)
library(colorspace)
library(tidyr)
library(ggplot2)
library(data.table)

source('ui-poseidon.R')
source('server-poseidon.R')

ysi <- readRDS("data/ysi.rds")

shinyApp(ui=ui, server=server)