if(!exists("INAPP")){
  cat("[Info] DO_profile_heatmap.R sourced for troubleshooting.\nMake sure to load data and packages from app.R first.\n")
  # Define "input" list for troubleshooting:
  input <- list(NULL)
  input$chosen.year <- "2014"
  input$slider.day <- "Mar 7"
}


fill.under.lines <- function(X, Y, YAxisMin, Color){
  poly.x <- c(min(X), X, max(X))
  poly.y <- c(YAxisMin, Y, YAxisMin )
  polygon(x = poly.x, y = poly.y, col = Color, border = NA)
}


index <- which(year(secchi$sample.date) == input$chosen.year)
my.secchi <- secchi[index, ]

y.lim <- c(-20,0)
col.dark <- adjustcolor(col = rainbow(n = 20, v = .5), alpha.f = .8)[13]
col.light <- adjustcolor(col = rainbow(n = 20, v = 1), alpha.f = .8)[12]

plot(x = my.secchi$sample.date, y = my.secchi$neg.depth, type = "n", ylim = y.lim)
fill.under.lines(X = my.secchi$sample.date, Y = my.secchi$neg.depth, YAxisMin = y.lim[1], Color = col.dark)
fill.under.lines(X = my.secchi$sample.date, Y = my.secchi$neg.depth, YAxisMin = y.lim[2], Color = col.light)
points(x = my.secchi$sample.date, y = my.secchi$neg.depth, pch = 21, col = "black", bg = adjustcolor("black",.5))



# choose colors:
plot(col =rainbow(20),1:20, cex = 5, pch = 19)
plot(col =rainbow(20, v = .6),1:20, cex = 5, pch = 19)
plot(col =adjustcolor(rainbow(20, v = 1), .8),1:20, cex = 5, pch = 19)
