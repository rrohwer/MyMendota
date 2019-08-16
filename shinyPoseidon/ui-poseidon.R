ui <- fluidPage(
  titlePanel("Lake Mendota Depth Profile"), 
  
  sidebarLayout(
    sidebarPanel(
      dateInput(inputId = "chosen.date",
                label="Choose a date",format = "yyyy-mm-dd"),
      
      dateRangeInput(inputId = "date.range",
                     label="Choose a date range",format = "yyyy-mm-dd",
                     min = min(ysi$sample.date), max=max(ysi$sample.date),
                     start = min(ysi$sample.date), end=max(ysi$sample.date)),
      
      selectInput(inputId="chosen.year",
                  label="Choose a year to highlight on the Secchi Depth plot",
                  choices = list("2014"=2014,"2015"=2015,"2016"=2016,"2017"=2017,"2018"=2018,"2019"=2019),
                  selected=2014),
      
      img(src = "~/Documents/MyMendota/shinyPoseidon/images/trina_lab.png", height = 200, width = 200)
    )
    ,
    
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
      )
    )
  )
)
