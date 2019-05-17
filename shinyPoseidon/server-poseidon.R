# RRR 5/16/19

# parse the ysi data into R ----

# do this for troubleshooting outside of running app (b/c app runs w/in poseidon folder but RProject is 1 folder up): setwd("shinyPoseidon")
ysi.file <- "data/example_YSI.csv"

ysi <- read.csv(file = ysi.file, header = TRUE, colClasses = "character", stringsAsFactors = F)

ysi$Timestamp <- parse_date_time(x = ysi$Timestamp, orders = "mdyHMS")
ysi$Timestamp <- floor_date(x = ysi$Timestamp, unit = "day")

ysi[ ,c(2:6,9)] <- apply(X = ysi[ ,c(2:6,9)], MARGIN = 2, FUN = as.numeric)

ysi <- cbind(ysi, "neg.depth" = ysi$Folder * -1)

date.options <- as.character(unique(ysi$Timestamp))
year.options <- as.character(unique(year(ysi$Timestamp)))

# try plots here ----

# chosen.date <- date.options[5]
# chosen.date.index <- which(as.character(ysi$Timestamp) == chosen.date)
# 
# par(mar = c(3,3,2,.5))
# plot(x = ysi$Temperature..C.[chosen.date.index], y = ysi$neg.depth[chosen.date.index], type = "n", ylim = c(-20,0), xlim = c(0, max(ysi$Temperature..C.)), axes = F, ann = F)
# points(x = ysi$Temperature..C.[chosen.date.index], y = ysi$neg.depth[chosen.date.index], pch = 21, col = "black", bg = adjustcolor("black",.5))
# axis(side = 1, at = c(0, max(ysi$Temperature..C.)), labels = F, lwd.ticks = 0)
# axis(side = 1, at = seq(from = 0, to = 25, by = 5), labels = F)
# axis(side = 1, at = seq(from = 0, to = 25, by = 5), tick = 0, labels = T, line = -.5)
# mtext(text = "Temperature (C)", side = 1, line = 1.75, outer = F)
# axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = F)
# axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = seq(from = -20, to = 0, by = 4) * -1, tick = 0, line = -.25, las = 2)
# mtext(text = "Depth (m)", side = 2, line = 2, outer = F)
# mtext(text = chosen.date, side = 3, line = 0, outer = F, cex = 1.5)

# ----
# 
# chosen.year <- year.options[1]
# chosen.year.index <- which(as.character(year(ysi$Timestamp)) == chosen.year)
# 
# heatmap.data <- ysi[chosen.year.index, c(1,11,6)]
# heatmap.data$Timestamp <- decimal_date(heatmap.data$Timestamp)
# heatmap.data <- interp(x = heatmap.data$Timestamp, y = heatmap.data$neg.depth, z = heatmap.data$Temperature..C., duplicate = "strip")
# image(heatmap.data, axes = F, col = sequential_hcl(n = 20, palette = "plasma"))
# axis(side = 1, label = F)
# axis(side = 1, tick = F, line = -.5)
# axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = F)
# axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = seq(from = -20, to = 0, by = 4) * -1, tick = 0, line = -.25, las = 2)
# mtext(text = "Depth (m)", side = 2, line = 2, outer = F)
# mtext(text = chosen.year, side = 3, line = 0, outer = F, cex = 1.5)

# define server inputs ----

server <- function(input, output){
  
  output$date.menu <- renderUI({
    selectInput("chosen.date", "Choose a Sample Date", as.list(date.options))
  })
  
  output$year.menu <- renderUI({
    selectInput("chosen.year", "Choose a Sampling Season", as.list(year.options))
  })
  
  output$temp.profile1 <- renderPlot({
    chosen.date.index <- which(as.character(ysi$Timestamp) == input$chosen.date)
    par(mar = c(3,3,2,.5))
    plot(x = ysi$Temperature..C.[chosen.date.index], y = ysi$neg.depth[chosen.date.index], type = "n", ylim = c(-20,0), xlim = c(0, max(ysi$Temperature..C.)), axes = F, ann = F)
    points(x = ysi$Temperature..C.[chosen.date.index], y = ysi$neg.depth[chosen.date.index], pch = 21, col = "black", bg = adjustcolor("black",.5))
    axis(side = 1, at = c(0, max(ysi$Temperature..C.)), labels = F, lwd.ticks = 0)
    axis(side = 1, at = seq(from = 0, to = 25, by = 5), labels = F)
    axis(side = 1, at = seq(from = 0, to = 25, by = 5), tick = 0, labels = T, line = -.5)
    mtext(text = "Temperature (C)", side = 1, line = 1.75, outer = F)
    axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = F)
    axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = seq(from = -20, to = 0, by = 4) * -1, tick = 0, line = -.25, las = 2)
    mtext(text = "Depth (m)", side = 2, line = 2, outer = F)
    mtext(text = input$chosen.date, side = 3, line = 0, outer = F, cex = 1.5)
  })
  
  output$temp.profile2 <- renderPlot({
    chosen.year.index <- which(as.character(year(ysi$Timestamp)) == input$chosen.year)
    heatmap.data <- ysi[chosen.year.index, c(1,11,6)]
    heatmap.data$Timestamp <- decimal_date(heatmap.data$Timestamp)
    heatmap.data <- interp(x = heatmap.data$Timestamp, y = heatmap.data$neg.depth, z = heatmap.data$Temperature..C., duplicate = "strip")
    image(heatmap.data, axes = F, col = sequential_hcl(n = 20, palette = "plasma"))
    #axis(side = 1, label = F)
    axis(side = 1, tick = T, line = 0,
         at = 2015 + yday(date.options)/365,
         label = date.options,
         srt = 90
         #at = 2015 + c(176, 182, 195, 204, 217, 222, 266, 278, 293, 310)/365,
         #label = c("6-24", "6-30", "7-13", "7-22", "8-04", "9-22", "10-04", "10-19", "11-05")
         )
    axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = F)
    axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = seq(from = -20, to = 0, by = 4) * -1, tick = 0, line = -.25, las = 2)
    mtext(text = "Depth (m)", side = 2, line = 2, outer = F)
    mtext(text = input$chosen.year, side = 3, line = 0, outer = F, cex = 1.5)
  })
  
}

