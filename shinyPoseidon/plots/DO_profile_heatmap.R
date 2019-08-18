if(!exists("INAPP")){
  cat("[Info] DO_profile_heatmap.R sourced for troubleshooting.\nMake sure to load data and packages from app.R first.\n")
  # Define "input" list for troubleshooting:
  input <- list(NULL)
  input$chosen.year <- "2014"
}

index <- which(ysi$Year == input$chosen.year)
heatmap.data <- ysi[index, c(1,10,7)]
heatmap.data$sample.date <- decimal_date(heatmap.data$sample.date)
heatmap.data <- interp(x = heatmap.data$sample.date, y = heatmap.data$neg.depth, z = heatmap.data$DO.mg.L, duplicate = "strip")

par(mar = c(3,3,2,.5))

image(heatmap.data, axes = F, col = sequential_hcl(n = 20, palette = "plasma"))
axis(side = 1)
# axis(side = 1, tick = T, line = 0, at = 2015 + yday(date.options)/365, srt = 90)
#at = 2015 + c(176, 182, 195, 204, 217, 222, 266, 278, 293, 310)/365,
#label = c("6-24", "6-30", "7-13", "7-22", "8-04", "9-22", "10-04", "10-19", "11-05")
axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = F)
axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = seq(from = -20, to = 0, by = 4) * -1, tick = 0, line = -.25, las = 2)
mtext(text = "Depth (m)", side = 2, line = 2, outer = F)
mtext(text = input$chosen.year, side = 3, line = 0, outer = F, cex = 1.5)




