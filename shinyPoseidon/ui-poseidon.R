ui <- fluidPage(
  titlePanel("Lake Mendota Depth Profile"), 
  
  sidebarLayout(
    sidebarPanel(
      dateInput(inputId = "chosen.date",
                label="Choose a date",format = "yyyy-mm-dd"),
      
      dateRangeInput(inputId = "date.range", # need to move this to server script with renderUI to not hard-code it
                     label="Choose a date range",format = "yyyy-mm-dd", 
                     min = parse_date_time("2014-05-30", "ymd"), max=parse_date_time("2019-08-14", "ymd"),
                     start =parse_date_time("2014-05-30", "ymd"), end=parse_date_time("2019-08-14", "ymd")
                     ),
      
      selectInput(inputId="chosen.year",
                  label="Choose a year to highlight on the Secchi Depth plot",
                  choices = list("2014"=2014,"2015"=2015,"2016"=2016,"2017"=2017,"2018"=2018,"2019"=2019),
                  selected=2014)
      
      
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
