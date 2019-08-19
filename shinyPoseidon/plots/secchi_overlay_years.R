if(!exists("INAPP")){
  cat("[Info] secchi_overlay_years.R sourced for troubleshooting.\nMake sure to load data and packages from app.R first.\n")
  input <- list(NULL)
  input$chosen.year <- "2014"
} #else {
#  cat("[Info] secchi_overlay_years.R called by shiny app.\n")
#}

p <- ggplot(data=secchi, aes(x=yday, y=neg.depth, group=Year)) +
  geom_line() +
  geom_point() +
  xlim(0,365) +
  ylab("Depth(m)")+
  xlab("Day of Year")

#p

# Add the line for just the year you want and highlight the date of the slider with an image of secchi depth :-) :
# Get data for line:
sub.secchi<-subset(secchi, secchi$Year == input$chosen.year)

# Get data for secchi:
my.date <- parse_date_time(x = paste(input$slider.day, input$chosen.year), orders = "mdy")
index <- which(secchi$sample.date == my.date)
my.secchi <- secchi[index, ]

# If the date is in YSI and in Secchi (not empty!)


# Add an image to the index of 

p <- p + geom_line(data = sub.secchi, aes(x=yday, y=neg.depth),colour="lightblue")+
  geom_area(data = sub.secchi, aes(x=yday, y=neg.depth), fill="lightblue", alpha=0.85)+
  geom_point(data = sub.secchi, aes(x=yday, y=neg.depth), col="lightblue")

p
# If there is a secchi depth for that date add a secchi image, otherwise just highlight the year:
if (dim(my.secchi)[1] != 0) {
    my.secchi$image <- "www/secchi.png"
    p <- p + geom_image(data = my.secchi, aes(image=image),asp = 1.90, size=0.025)
}

p <- p+theme(legend.position="none")

print(p) # ggplot objects must be explicitly returned with print() when called by sourcing.
