

server <- function(input,output){
  str(ysi)
  ## Temperature Tab plot:
  output$temp.profile1 <- renderPlot({
    chosen.date.index <- which(as.character(ysi$sample.date) == input$chosen.date)
    par(mar = c(3,3,2,.5))
    plot(x = ysi$temp.C[chosen.date.index], y = ysi$neg.depth[chosen.date.index], type = "n", ylim = c(-20,0), xlim = c(0, max(ysi$temp.C)), axes = F, ann = F)
    points(x = ysi$temp.C[chosen.date.index], y = ysi$neg.depth[chosen.date.index], pch = 21, col = "black", bg = adjustcolor("black",.5))
    axis(side = 1, at = c(0, max(ysi$temp.C)), labels = F, lwd.ticks = 0)
    axis(side = 1, at = seq(from = 0, to = 25, by = 5), labels = F)
    axis(side = 1, at = seq(from = 0, to = 25, by = 5), tick = 0, labels = T, line = -.5)
    mtext(text = "Temperature (C)", side = 1, line = 1.75, outer = F)
    axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = F)
    axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = seq(from = -20, to = 0, by = 4) * -1, tick = 0, line = -.25, las = 2)
    mtext(text = "Depth (m)", side = 2, line = 2, outer = F)
    mtext(text = input$chosen.date, side = 3, line = 0, outer = F, cex = 1.5)
  })
  
  output$temp.profile2 <- renderPlot({
    #chosen.year.index <- which(as.character(year(ysi$sample.date)) == input$data.range)
    # heatmap.data <- ysi[chosen.year.index, c(1,11,6)]
    # This only works if you have a data.table
    
    heatmap.data <- ysi.DT[sample.date>=input$date.range[1] & sample.date<=input$date.range[2]]
    # test
    #input$data[1] = "201"
    heatmap.data$sample.date <- decimal_date(heatmap.data$sample.date)
    heatmap.data <- interp(x = heatmap.data$sample.date, y = heatmap.data$neg.depth, z = heatmap.data$temp.C, duplicate = "strip")
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
    mtext(text = paste(as.character(input$date.range[1]),"to",as.character(input$date.range[2])), side = 3, line = 0, outer = F, cex = 1.5)
  })
  
  ## DO tab plot
  
  output$do.profile1 <- renderPlot({
    chosen.date.index <- which(as.character(ysi$sample.date) == input$chosen.date)
    par(mar = c(3,3,2,.5))
    plot(x = ysi$DO.mg.L[chosen.date.index], y = ysi$neg.depth[chosen.date.index], type = "n", ylim = c(-20,0), xlim = c(0, max(ysi$DO.mg.L)), axes = F, ann = F)
    points(x = ysi$DO.mg.L[chosen.date.index], y = ysi$neg.depth[chosen.date.index], pch = 21, col = "black", bg = adjustcolor("black",.5))
    axis(side = 1, at = c(0, max(ysi$DO.mg.L)), labels = F, lwd.ticks = 0)
    axis(side = 1, at = seq(from = 0, to = 25, by = 5), labels = F)
    axis(side = 1, at = seq(from = 0, to = 25, by = 5), tick = 0, labels = T, line = -.5)
    mtext(text = "Dissolved Oxygen (mg/L)", side = 1, line = 1.75, outer = F)
    axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = F)
    axis(side = 2, at = seq(from = -20, to = 0, by = 4), labels = seq(from = -20, to = 0, by = 4) * -1, tick = 0, line = -.25, las = 2)
    mtext(text = "Depth (m)", side = 2, line = 2, outer = F)
    mtext(text = input$chosen.date, side = 3, line = 0, outer = F, cex = 1.5)
  })
  
  output$do.profile2 <- renderPlot({
    chosen.year.index <- which(as.character(year(ysi$sample.date)) == input$data.range)
    # heatmap.data <- ysi[chosen.year.index, c(1,11,6)]
    # This only works if you have a data.table
    
    heatmap.data <- ysi.DT[sample.date>=input$date.range[1] & sample.date<=input$date.range[2]]
    # test
    #input$data[1] = "201"
    heatmap.data$sample.date <- decimal_date(heatmap.data$sample.date)
    heatmap.data <- interp(x = heatmap.data$sample.date, y = heatmap.data$neg.depth, z = heatmap.data$DO.mg.L, duplicate = "strip")
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
    mtext(text = paste(as.character(input$date.range[1]),"to",as.character(input$date.range[2])), side = 3, line = 0, outer = F, cex = 1.5)
  })
  
  
  ## Secchi Tab plot
  # Line plot and colour in red the selected year
  output$secchi.plot <- renderPlot({
    
    p <- ggplot(data=secchi, aes(x=yday, y=neg.depth, group=Year)) +
      geom_line() +
      geom_point() +
      xlim(0,365) +
      ylab("Depth(m)")+
      xlab("Day of Year")
    # Add the line for just the year you want:
    sub.secchi<-subset(secchi, secchi$Year == input$chosen.year)
    # test:
    #sub.secchi <- subset(secchi, secchi$Year == 2014)
    p + geom_line(data = sub.secchi, aes(x=yday, y=neg.depth, col="red"))+
      geom_point(data = sub.secchi, aes(x=yday, y=neg.depth, col="red"))
    
  })
  
}