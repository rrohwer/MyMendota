ui <- fluidPage(
  titlePanel("Lake Mendota Depth Profile"), 
  
  sidebarLayout(
    sidebarPanel(
      
      uiOutput("year.dropdown.menu"), 
      
      uiOutput("slider.text.widget"),
      
      #uiOutput("TempSelection")
      radioButtons(inputId = "TempPref",
      label="Temperature Units:",
      choices = c("Celcius", "Farenheit"),
      selected="Celcius",
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
      img(src = "trina_lab.png", height = 200, width = 200)
    )
  )
)
