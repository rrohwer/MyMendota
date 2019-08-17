

server <- function(input,output){
  
  ## Temperature Tab 
  
  output$temp.profile1 <- renderPlot({
    cat("\ntemp tab- input$chosen.date")
    cat(input$chosen.date)
    cat(str(input$chosen.date))
    source(file = "plots/temp_profile_daily.R", local = TRUE)
  })
  
  output$temp.profile2 <- renderPlot({
    cat("\ntemp tab- input$date.range\n")
    cat(input$date.range, "\n")
    cat(str(input$date.range), "\n")
    source(file = "plots/temp_profile_heatmap.R", local = TRUE)
  })
  
  ## DO Tab
  
  output$do.profile1 <- renderPlot({
    cat("\nDO tab- input$chosen.date")
    cat(input$chosen.date, "\n")
    cat(str(input$chosen.date), "\n")
    source(file = "plots/DO_profile_daily.R", local = TRUE)
  })
  
  output$do.profile2 <- renderPlot({
    cat("\nDO tab- input$date.range\n")
    cat(input$date.range, "\n")
    cat(str(input$date.range), "\n")
    source(file = "plots/DO_profile_heatmap.R", local = TRUE)
  })
  
  
  ## Secchi Tab 
  
  output$secchi.plot <- renderPlot({
    cat("\nsecchi tab- input$chosen.year\n")
    cat(input$chosen.year, "\n")
    cat(str(input$chosen.year), "\n")
    source(file = "plots/secchi_overlay_years.R", local = TRUE)
  })
  
}