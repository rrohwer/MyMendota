library(shiny)
# trying to use all the tidyverse packages. These are the "core" ones, plus lubridate
library(readr) # reads in data to tibble format
library(ggplot2)
library(tibble)
library(tidyr)
library(purrr)
library(dplyr)
library(lubridate)

source('ui.R')
source('server.R')


shinyApp(ui=ui, server=server)