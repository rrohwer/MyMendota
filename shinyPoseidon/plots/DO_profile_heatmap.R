if(!exists("INAPP")){
  cat("[Info] DO_profile_heatmap.R sourced for troubleshooting.\nMake sure to load data and packages from app.R first.\n")
  # Define "input" list for troubleshooting:
  input <- list(NULL)
  input$chosen.year <- "2014"
  input$slider.day <- "Mar 7"
}

index <- which(ysi$Year == input$chosen.year)
heatmap.data <- ysi[index, c(1,10,7)]
valid.indexes = !is.na(heatmap.data$DO.mg.L)
unique.dates <- decimal_date(unique(heatmap.data$sample.date))
heatmap.data$sample.date <- decimal_date(heatmap.data$sample.date)
heatmap.data <- interp(x = heatmap.data$sample.date[valid.indexes], y = heatmap.data$neg.depth[valid.indexes], z = heatmap.data$DO.mg.L[valid.indexes], duplicate = "strip")

par(mar = c(4.5,3,2,0.5))

image.plot(heatmap.data, axes = F, col = viridis(20),zlim=c(0,14))
day.choices <- unique(ysi$sample.date[index])
day.choices <- paste(lubridate::month(x = day.choices, label = TRUE, abbr = TRUE), day(x = day.choices))

axis(side = 1, at= unique.dates, col = "black", labels=day.choices, las=2)

# axis(side = 1, tick = T, line = 0, at = 2015 + yday(date.options)/365, srt = 90)
#at = 2015 + c(176, 182, 195, 204, 217, 222, 266, 278, 293, 310)/365,
#label = c("6-24", "6-30", "7-13", "7-22", "8-04", "9-22", "10-04", "10-19", "11-05")
axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = F)
axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = seq(from = -20, to = 0, by = 4) * -1, tick = 0, line = -.25, las = 2)

# show vertical line on heatmap for selected date
my.date <- parse_date_time(x = paste(input$slider.day, input$chosen.year), orders = "mdy")
abline(v=decimal_date(my.date),col='black',lwd=4,lty=2)

mtext("mg/L",side=4,line=3.8,cex=1.5)

mtext(text = "Depth (m)", side = 2, line = 2, outer = F)
mtext(text = input$chosen.year, side = 3, line = 0, outer = F, cex = 1.5)

