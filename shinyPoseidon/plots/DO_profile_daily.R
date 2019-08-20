if(!exists("INAPP")){
  cat("[Info] DO_profile_daily.R sourced for troubleshooting.\nMake sure to load data and packages from app.R first.\n")
  # Define "input" list for troubleshooting:
  input <- list(NULL)
  input$chosen.year <- "2014"
  input$slider.day <- "Jul 4"
}

my.date <- parse_date_time(x = paste(input$slider.day, input$chosen.year), orders = "mdy")
index <- which(ysi$sample.date == my.date)
my.ysi <- ysi[index, ]

y.lim <- c(-20,0)
x.lim <- c(0, max(ysi$DO.mg.L, na.rm = TRUE))

t=seq(0,21,0.5)
y=0.7*sin(t)
#plot(t,y, ylim = y.lim, type="l", xlab="time", ylab="Sine wave")

par(mar = c(3,3,2,.5))
plot(x = my.ysi$DO.mg.L, y = my.ysi$neg.depth, type = "n", ylim = y.lim, xlim = x.lim, axes = F, ann = F)
plot(t,y, ylim = c(-20,1), xlim=x.lim, type="l", axes=F, ann=F,col='blue',lty=2,lwd=2)
points(x = my.ysi$DO.mg.L, y = my.ysi$neg.depth, pch = 21, col = "black", bg = adjustcolor("black",.5))
axis(side = 1, at = x.lim, labels = F, lwd.ticks = 0)
axis(side = 1, at = seq(from = 0, to = 20, by = 5), labels = F)
axis(side = 1, at = seq(from = 0, to = 20, by = 5), tick = 0, labels = T, line = -.5)
mtext(text = "Dissolved Oxygen (mg/L)", side = 1, line = 1.75, outer = F)
axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = F)
axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = seq(from = -20, to = 0, by = 4) * -1, tick = 0, line = -.25, las = 2)
text(1.5,1.1,labels="[Lake Surface: Depth=0]",cex=0.75)
mtext(text = "Depth (m)", side = 2, line = 2, outer = F)
mtext(text = paste(input$slider.day, input$chosen.year, sep = ", "), side = 3, line = 0, outer = F, cex = 1.5)





