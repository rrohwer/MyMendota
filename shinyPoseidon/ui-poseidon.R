# RRR 5/16/19

ui <- fluidPage(

    titlePanel("Lake Mendota Depth Profile"), 

    sidebarLayout(
      sidebarPanel(
        h2("Select a date to view its depth profile:"),
        br(),
        br(),
        uiOutput("date.menu"),
        br(),
        uiOutput("year.menu"),
        br(),
        br(),
        img(src = "trina_lab.png", height = 200, width = 200),
        br()
      ),
      
      mainPanel(
        plotOutput("temp.profile1"),
        br(),
        plotOutput("temp.profile2")      
      )
    )
  )
