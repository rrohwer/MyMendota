# Atul played around with example layouts and new shiny syntax

ui <- fluidPage(

    titlePanel("Mendota Depth Profile"), 

    sidebarLayout(
      sidebarPanel(
        h2("Here you select an option"),
        h3("See there is a dropdown menu?"),
        h5("I know senator you do not know how to use a computer. Let me click this for you."),
        br(),
        br(),
        #uiOutput("unique.days"),
        selectInput("selected.option", choices=c('1','2','3','4'), label='Select a slope for the line plot.'),
        br(),
        br(),
        sliderInput("ymax",
                    "Number of observations:",
                    value = 10,
                    min = 0,
                    max = 20),
        br(),
        br(),
        img(src = "trina_lab.png", height = 200, width = 200),
        br(),
        "Copyright 2019."
      ),
      
      
      
      mainPanel(
        h1("OOOOoooo look at that plot senator!"),
        h6("(Senator, you are probably too old and need special glasses to read this small font. Don't worry, nothing important here.)"),
        p("Here is a new paragrah of text which has"),
        strong("strong text"),
        em("italics text"),
        "and also",
        div("div support to get green text!",style="color:green"),
        "and back to normal text.",
        br(),
        plotOutput("temp.profile"),
        tabsetPanel(type="tabs",
                   tabPanel("Plot2", plotOutput("temp.profile2")),
                   tabPanel("Plot3", plotOutput("temp.profile3")) 
                   )
      )
    )
  )
