ui <- fluidPage(
  titlePanel("Lake Mendota Depth Profile"), 
  
  sidebarLayout(
    sidebarPanel(
      
      uiOutput("year.dropdown.menu"), 
      
      uiOutput("slider.text.widget")
   ),
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Temperature", 
                          br(),
                          radioButtons(inputId = "TempPref",
                            label="Temperature Units:",
                            choices = c("Celsius", "Fahrenheit"),
                            selected="Fahrenheit",
                            inline = TRUE),
                          br(),
                          plotOutput("temp.profile1"),
                          plotOutput("temp.profile2")
                  ),
                  tabPanel("Dissolved oxygen", 
                           plotOutput("do.profile1"),
                           plotOutput("do.profile2")
                  ),
                  tabPanel("Secchi", 
                           plotOutput("secchi.individual"),
                           plotOutput("secchi.plot")
                           
                  )
                  
      ),
      br(),
      img(src = "logos.png", width= "90%")
    )
  )
)
