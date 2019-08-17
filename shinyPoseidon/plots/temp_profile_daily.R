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