if(!exists("INAPP")){
  cat("[Info] temp_profile_daily.R sourced for troubleshooting.\nMake sure to load data and packages from app.R first.\n")
  # Define "input" list for troubleshooting:
  input <- list(NULL)
  input$chosen.year <- "2014"
  input$slider.day <- "Jul 4"
  input$TempPref="Fahrenheit"
}


my.date <- parse_date_time(x = paste(input$slider.day, input$chosen.year), orders = "mdy")
index <- which(ysi$sample.date == my.date)
my.ysi <- ysi[index, ]

y.lim <- c(-65.6,0)

if(input$TempPref == "Celsius"){
  t <- seq(from = 0, to = 25, length.out = 100)
  y <- -abs(x = 3.0 * sin(t))
  y <- y - min(y)
  my.temp <- my.ysi$temp.C
  x.lim <- c(0, max(ysi$temp.C, na.rm = TRUE))
  ax.lab <- "Temperature (C)"
  x.ax.locs <- seq(from = 0, to = 25, by = 5)
}else{
  t <- seq(from = 32, to = 77, length.out = 100)
  y <- -abs(x = 3.0 * sin( (t / (9/5)) + pi/2)) 
  y <- y - min(y)
  my.temp <- my.ysi$temp.F
  x.lim <- c(32, max(ysi$temp.F, na.rm = TRUE))
  ax.lab <- "Temperature (F)"
  x.ax.locs <- seq(from = 32, to = 77, by = 5)
}  
  
par(mar = c(3,3,3,.5))

plot(x = my.temp, y = my.ysi$neg.depth, type = "n", ylim = y.lim, xlim = x.lim, axes = F, ann = F)
lines(x = t, y = y, col = adjustcolor("blue",.5), lwd = 5, xpd = NA)
points(x = my.temp, y = my.ysi$neg.depth, pch = 21, col = "black", bg = adjustcolor("black",.5))
axis(side = 1, at = x.lim, labels = F, lwd.ticks = 0)
axis(side = 1, at = x.ax.locs, labels = F)
axis(side = 1, at = x.ax.locs, tick = 0, labels = T, line = -.5)
mtext(text = ax.lab, side = 1, line = 1.75, outer = F)
axis(side = 2, at = seq(from = -65, to = 0, by = 5), labels = F)
axis(side = 2, at = seq(from = -65, to = 0, by = 5), labels = seq(from = -65, to = 0, by = 5) * -1, tick = 0, line = -.25, las = 2)
text(x = x.lim[1], y = 5, labels="(Lake Surface: Depth = 0)", cex = 0.75, xpd = NA)
mtext(text = "Depth (feet)", side = 2, line = 2, outer = F)
mtext(text = paste(input$slider.day, input$chosen.year, sep = ", "), side = 3, line = 1.7, outer = F, cex = 1.5)

