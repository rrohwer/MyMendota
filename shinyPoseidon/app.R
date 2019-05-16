library(shiny)


source('ui-senator.R')
source('server-senator.R')


shinyApp(ui=ui, server=server)