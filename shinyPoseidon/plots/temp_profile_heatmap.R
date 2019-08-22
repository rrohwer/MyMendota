if(!exists("INAPP")){
  cat("[Info] temp_profile_heatmap.R sourced for troubleshooting.\nMake sure to load data and packages from app.R first.\n")
  # Define "input" list for troubleshooting:
  input <- list(NULL)
  input$chosen.year <- "2014"
  input$slider.day <- "Nov 9"
  input$TempPref <- "Celcius"
}



index <- which(ysi$Year == input$chosen.year)
heatmap.data <- ysi[index, c(1,10,6,11)]
unique.dates <- decimal_date(unique(heatmap.data$sample.date))
heatmap.data$sample.date <- decimal_date(heatmap.data$sample.date)

par(mar = c(4.5,3,2,0.5))

if(input$TempPref=="Celcius") {
  valid.indexes = !is.na(heatmap.data$temp.C)
  heatmap.data <- interp(x = heatmap.data$sample.date[valid.indexes], y = heatmap.data$neg.depth[valid.indexes], z = heatmap.data$temp.C[valid.indexes], duplicate = "strip")
  image.plot(heatmap.data, axes = F, col = sequential_hcl(n = 20, palette = "plasma"),zlim=c(0,27))
} else {
  valid.indexes = !is.na(heatmap.data$temp.F)
  heatmap.data <- interp(x = heatmap.data$sample.date[valid.indexes], y = heatmap.data$neg.depth[valid.indexes], z = heatmap.data$temp.F[valid.indexes], duplicate = "strip")
  image.plot(heatmap.data, axes = F, col = sequential_hcl(n = 20, palette = "plasma"),zlim=c(32,81))
}


day.choices <- unique(ysi$sample.date[index])
day.choices <- paste(lubridate::month(x = day.choices, label = TRUE, abbr = TRUE), day(x = day.choices))
#day.choices[seq(2,length(day.choices)-1)]="" # only show first and last day names

axis(side = 1, at= unique.dates, col = "black", labels=as.character(day.choices),las=2)#, labels = unique.dates)
# axis(side = 1, tick = T, line = 0, at = 2015 + yday(date.options)/365, srt = 90)
     #at = 2015 + c(176, 182, 195, 204, 217, 222, 266, 278, 293, 310)/365,
     #label = c("6-24", "6-30", "7-13", "7-22", "8-04", "9-22", "10-04", "10-19", "11-05")
axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = F)

axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = seq(from = -20, to = 0, by = 4) * -1, tick = 0, line = -.25, las = 2)

# show vertical line on heatmap for selected date
my.date <- parse_date_time(x = paste(input$slider.day, input$chosen.year), orders = "mdy")
abline(v=decimal_date(my.date),col='black',lwd=4,lty=2)

if(input$TempPref=="Celcius") {
  mtext("deg C",side=4,line=4,cex=1.5)
} else
{
  mtext("deg F",side=4,line=4,cex=1.5)
  #text(heatmap.data$x[length(heatmap.data$x)]+0.04,0,labels="deg F",cex=1.00,xpd=T)
}

mtext(text = "Depth (m)", side = 2, line = 2, outer = F)
mtext(text = input$chosen.year, side = 3, line = 0, outer = F, cex = 1.5)



