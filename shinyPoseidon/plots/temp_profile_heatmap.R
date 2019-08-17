# RRR 8/17/19

# # Define "input" list for troubleshooting:
# cat("shit comment out the troubleshooting hard-coding!")
# input <- list(NULL)
# secchi$sample.date <- parse_date_time("2019-08-17", "ymd")
# input$date.range <- parse_date_time(x = c("2014-05-30", "2019-08-14"), orders = "ymd")





#chosen.year.index <- which(as.character(year(ysi$sample.date)) == input$data.range)
# heatmap.data <- ysi[chosen.year.index, c(1,11,6)]
# This only works if you have a data.table

heatmap.data <- ysi.DT[sample.date >= input$date.range[1] & sample.date <= input$date.range[2]]
# test
#input$data[1] = "201"
heatmap.data$sample.date <- decimal_date(heatmap.data$sample.date)
heatmap.data <- interp(x = heatmap.data$sample.date, y = heatmap.data$neg.depth, z = heatmap.data$temp.C, duplicate = "strip")
image(heatmap.data, axes = F, col = sequential_hcl(n = 20, palette = "plasma"))
#axis(side = 1, label = F)
axis(side = 1, tick = T, line = 0,
     at = 2015 + yday(date.options)/365,
     label = date.options,
     srt = 90)
     #at = 2015 + c(176, 182, 195, 204, 217, 222, 266, 278, 293, 310)/365,
     #label = c("6-24", "6-30", "7-13", "7-22", "8-04", "9-22", "10-04", "10-19", "11-05")
axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = F)
axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = seq(from = -20, to = 0, by = 4) * -1, tick = 0, line = -.25, las = 2)
mtext(text = "Depth (m)", side = 2, line = 2, outer = F)
mtext(text = paste(as.character(input$date.range[1]),"to",as.character(input$date.range[2])), side = 3, line = 0, outer = F, cex = 1.5)


