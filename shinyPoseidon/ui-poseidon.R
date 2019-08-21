ui <- fluidPage(
  titlePanel("Lake Mendota Depth Profile"), 
  
  sidebarLayout(
    sidebarPanel(
      
      uiOutput("year.dropdown.menu"), 
      
      uiOutput("slider.text.widget"),
      
      radioButtons(inputId = "TempPref",
      label="Temperature Units:",
      choices = c("Celcius", "Fahrenheit"),
      selected="Fahrenheit",
      inline = TRUE)

    ),
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Temperature", 
                           plotOutput("temp.profile1"),
                           plotOutput("temp.profile2")
                  ),
                  tabPanel("Dissolved oxygen", 
                           plotOutput("do.profile1"),
                           plotOutput("do.profile2")
                  ),
                  tabPanel("Secchi", 
                           plotOutput("secchi.plot")
                  )
                  
      ),
      br(),
      img(src = "logos.png", heigth="50%", width= "50%")
    )
  )
)
