

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
                 day.choices <- paste(lubridate::month(x = day.choices, label = TRUE, abbr = TRUE), day(x = day.choices))
                 sliderTextInput(inputId = "slider.day", label = "Choose a sample date", choices = day.choices)
               })
               }
  )
  
  
  ## Temperature Tab 
  
  observeEvent( input$slider.day, { 
  output$temp.profile1 <- renderPlot({
    cat("\ntemp tab- input$slider.day\n")
    cat(input$slider.day,'\n')
    cat(str(input$slider.day),'\n')
    source(file = "plots/temp_profile_daily.R", local = TRUE)
  }) } )
  
  observeEvent( input$chosen.year, {
  output$temp.profile2 <- renderPlot({
    cat("\ntemp tab- input$chosen.year\n")
    cat(input$chosen.year, "\n")
    cat(str(input$chosen.year), "\n")
    source(file = "plots/temp_profile_heatmap.R", local = TRUE)
  }) } )
  
  ## DO Tab
  
  observeEvent( input$slider.day, {
  output$do.profile1 <- renderPlot({
    cat("\nDO tab- input$slider.day\n")
    cat(input$slider.day, "\n")
    cat(str(input$slider.day), "\n")
    source(file = "plots/DO_profile_daily.R", local = TRUE)
  }) } )
  
  observeEvent( input$chosen.year, {
  output$do.profile2 <- renderPlot({
    cat("\nDO tab- input$chosen.year\n")
    cat(input$chosen.year, "\n")
    cat(str(input$chosen.year), "\n")
    source(file = "plots/DO_profile_heatmap.R", local = TRUE)
  }) })
  
  
  ## Secchi Tab 
  
  observeEvent(eventExpr = input$chosen.year, {
  output$secchi.plot <- renderPlot({
    cat("\nsecchi tab- input$chosen.year\n")
    cat(input$chosen.year, "\n")
    cat(str(input$chosen.year), "\n")
    source(file = "plots/secchi_overlay_years.R", local = TRUE)
  }) } )
  
}