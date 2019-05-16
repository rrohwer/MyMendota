# Atul played around with example layouts and new shiny syntax

server <- function(input, output){
  
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
  
}

