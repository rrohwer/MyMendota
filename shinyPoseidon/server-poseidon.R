

server <- function(input,output){
  
  ## widgets that decide their options based on data
  
  output$year.dropdown.menu <- renderUI({
    year.choices <- as.character(unique(ysi$Year))
    names(year.choices) <- year.choices
    selectInput(inputId = "chosen.year", label = "Choose a year", choices = year.choices, selected = 2019)
  })
  
  observeEvent(eventExpr = input$chosen.year, # don't show error, wait for year dropdown input to be entered.
               handlerExpr = {output$slider.text.widget <- renderUI({
                 index <- as.character(ysi$Year) == input$chosen.year
                 day.choices <- unique(ysi$sample.date[index])
                 day.choices <- paste(month(x = day.choices, label = TRUE, abbr = TRUE), day(x = day.choices))
                 sliderTextInput(inputId = "slider.day", label = "Choose a sample date", choices = day.choices)
               })
               }
  )
  
  
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