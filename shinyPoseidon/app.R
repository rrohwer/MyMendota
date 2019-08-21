library(shiny)
library(lubridate)
library(akima)
library(colorspace)
library(tidyr)
library(ggplot2)
library(shinyWidgets)
library(ggimage)
library(fields)
library(viridis)

ysi <- readRDS("data/ysi.rds")
ysi$neg.depth <- -1 * ysi$depth.m
# ysi.DT <- as.data.table(ysi)
# convert temp to F:
ysi$temp.F <- (ysi$temp.C * 9/5) + 32

secchi <- readRDS("data/secchi.rds")
secchi <- separate(data = secchi, col = sample.date, into = c("Year", "Month", "Day"), remove = FALSE)
secchi$neg.depth <- -1 * secchi$secchi.depth.m
secchi$yday <- yday(secchi$sample.date)

source('ui-poseidon.R')
source('server-poseidon.R', local = TRUE)

# plotting scripts use this global to figure out if the app is running the
# script or if the script is being sourced as a stand-alone script for debugging
INAPP = TRUE

shinyApp(ui=ui, server=server)
