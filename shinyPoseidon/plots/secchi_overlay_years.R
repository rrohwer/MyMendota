
# # Define "input" list for troubleshooting:
# cat("shit comment out the troubleshooting hard-coding!")
# input <- list(NULL)
# input$chosen.year <- "2014"

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
p <- p + geom_line(data = sub.secchi, aes(x=yday, y=neg.depth, col="red"))+
  geom_point(data = sub.secchi, aes(x=yday, y=neg.depth, col="red"))

print(p) # ggplot objects must be explicitly returned with print() when called by sourcing.
