# RRR 4-11-17
# Final Project for LTER datasets class
# Use all the new packages to make a simple YSI depth profile plot

# ---- Define File Paths and Dependencies ----

# If not soucing as app need to set dir to inside the app's folder setwd(dir = "PlotPoseidon/")

ysi.file <- "data/example_YSI.csv"

#library(shiny)
## trying to use all the tidyverse packages. These are the "core" ones, plus lubridate
#library(readr) # reads in data to tibble format
#library(ggplot2)
#library(tibble)
#library(tidyr)
#library(purrr)
#library(dplyr)
#library(lubridate)

# ---- Import and Format data ----

# readr package imports files into tibble format. 
# source without col_types and use the copy/paste output to change it.
ysi <- read_csv(file = ysi.file, col_names = T, col_types = cols(
  Timestamp = col_character(),
  `Barometer (kPA)` = col_double(),
  `Specific Conductance (uS/cm)` = col_double(),
  `Dissolved Oxygen (mg/L)` = col_double(),
  `pH_1 (Units)` = col_double(),
  `Temperature (C)` = col_double(),
  Comment = col_character(),
  Site = col_character(),
  Folder = col_double(),
  `Unit ID` = col_character()
)) 

# lubridate seems more reliable and flexible than readr's parse_datetime function.
# use dpylr's piping, well, technically magrittr
ysi$Timestamp <-
  ysi %>%
  select(Timestamp) %>%
  as_vector() %>% # Tibbles don't drop dimensions automatically
  parse_date_time(orders = "mdyHMS", tz = "Etc/GMT-5") %>% 
  floor_date(unit = "day")

ysi <- ysi %>%
  mutate(negDepth = Folder * -1)

# This piping seems take much longer to type compared to more concise not-piped:
# ysi$Timestamp <- parse_date_time(x = ysi$Timestamp, orders = "mdyHMS", tz = "Etc/GMT-5")
# ysi$Timestamp <- floor_date(x = ysi$Timestamp, unit = "day")


# ---- User chooses date to plot profile ----




server <- function(input, output){
  
  # options for dropdown menu (must be character?)
  #output$unique.days <- renderUI({
  #  selectInput("sample.day", choices = unique(ysi$Timestamp), label = "Choose a day to plot")
  #})
  
  #output$unique.days <- renderUI({
  #  selectInput("selected.option", choices=c('1','2','3','4'), label='Select a slope for the line plot.')
  #})
    
  # plot for main panel, requires input from dropdown menu
  
  output$temp.profile <- renderPlot(
    {
    cat('hello', str(input$selected.option))
    x = c(1,2,3,4)
    y = as.numeric(input$selected.option) * x
    plot(x,y, ylim=c(0,input$ymax), type='o')
    title(main=paste('hello',input$selected.option)) 
    }
  )
  
  output$temp.profile2 <- renderPlot(plot(c(1,2,3),c(1,2,3),main=input$selected.option))
  output$temp.profile3 <- renderPlot(plot(c(1,2,3),c(5,6,7),main=input$ymax))
  
  #output$temp.profile <- renderPlot({
  #  cat('hello ', str(input$sample.day))
  #  cat("2", parse_date_time(input$sample.day, "ymd", tz="Etc/GMT-5"), str(parse_date_time(input$sample.day, "ymd", tz="Etc/GMT-5")))
  #  ysi %>%
  #    filter(Timestamp == parse_date_time(input$sample.day, "ymd", tz="Etc/GMT-5")) %>% # input comes as character?
  #    select(negDepth, Folder, `Temperature (C)`) %>%
  #    ggplot(mapping = aes(x = `Temperature (C)`, y = negDepth)) +
  #    geom_point() +
  #    labs(x = "Temperature (C)", y = "Depth (m)", 
  #         title = paste("Lake Mendota Thermocline on", input$sample.day))
  #    # theme(axis.text.y = Folder) # does not work. trying to get positive labels
  #})
}


# test2<- ysi %>%
#   filter(Timestamp == input$sample.day) %>% # input comes as character?
#   select(negDepth, Folder, `Temperature (C)`) %>%
#   
# 
# ggplot(data = test, mapping = aes(x = test$`Temperature (C)`, y = test$negDepth)) +
#   geom_point() +
#   
# 
# 
# plot(x = test$`Temperature (C)`, y = test$Folder)
# 
# 
# 
