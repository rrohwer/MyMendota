# RRR 4-11-17
# Final Project for LTER datasets class
# Use all the new packages to make a simple YSI depth profile plot

library(shiny)

shinyUI(
  fluidPage(
    titlePanel("Mendota Depth Profile"), 
    sidebarLayout(
      sidebarPanel(
        uiOutput("unique.days")
      ),
      mainPanel(
        plotOutput("temp.profile")
      )
    )
  )
)





