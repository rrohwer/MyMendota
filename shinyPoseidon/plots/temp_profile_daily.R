if(!exists("INAPP")){
  cat("[Info] temp_profile_daily.R sourced for troubleshooting.\nMake sure to load data and packages from app.R first.\n")
  # Define "input" list for troubleshooting:
  input <- list(NULL)
  input$chosen.year <- "2014"
  input$slider.day <- "Jul 4"
}


my.date <- parse_date_time(x = paste(input$slider.day, input$chosen.year), orders = "mdy")
index <- which(ysi$sample.date == my.date)
my.ysi <- ysi[index, ]

y.lim <- c(-20,0)
x.lim <- c(0, max(ysi$temp.C, na.rm = TRUE))
x.lim.F <- c(32, max(ysi$temp.F, na.rm = TRUE))


par(mar = c(3,3,2,.5))

if (input$TempPref == "Celcius"){
  plot(x = my.ysi$temp.C, y = my.ysi$neg.depth, type = "n", ylim = y.lim, xlim = x.lim, axes = F, ann = F)
  points(x = my.ysi$temp.C, y = my.ysi$neg.depth, pch = 21, col = "black", bg = adjustcolor("black",.5))
  axis(side = 1, at = x.lim, labels = F, lwd.ticks = 0)
  axis(side = 1, at = seq(from = 0, to = 25, by = 5), labels = F)
  axis(side = 1, at = seq(from = 0, to = 25, by = 5), tick = 0, labels = T, line = -.5)
  mtext(text = "Temperature (C)", side = 1, line = 1.75, outer = F)
  axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = F)
  axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = seq(from = -20, to = 0, by = 4) * -1, tick = 0, line = -.25, las = 2)
  mtext(text = "Depth (m)", side = 2, line = 2, outer = F)
  mtext(text = paste(input$slider.day, input$chosen.year, sep = ", "), side = 3, line = 0, outer = F, cex = 1.5)
  
} else {
  plot(x = my.ysi$temp.F, y = my.ysi$neg.depth, type = "n", ylim = y.lim, xlim = x.lim.F, axes = F, ann = F)
  points(x = my.ysi$temp.F, y = my.ysi$neg.depth, pch = 21, col = "black", bg = adjustcolor("black",.5))
  axis(side = 1, at = x.lim.F, labels = F, lwd.ticks = 0)
<<<<<<< HEAD
#  axis(side = 1, at = seq(from = 0, to = 85, by = 10), labels = F)
#  axis(side = 1, at = seq(from = 0, to = 85, by = 10), tick = 0, labels = T, line = -.5)
=======
>>>>>>> 9798082e5712a4fad7f1bc5944cabaa638b5e644
  axis(side = 1, at = seq(from = 32, to = 77, by = 5), labels = F)
  axis(side = 1, at = seq(from = 32, to = 77, by = 5), tick = 0, labels = T, line = -.5)
  mtext(text = "Temperature (F)", side = 1, line = 1.75, outer = F)
  axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = F)
  axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = seq(from = -20, to = 0, by = 4) * -1, tick = 0, line = -.25, las = 2)
  mtext(text = "Depth (m)", side = 2, line = 2, outer = F)
  mtext(text = paste(input$slider.day, input$chosen.year, sep = ", "), side = 3, line = 0, outer = F, cex = 1.5)
  
}
