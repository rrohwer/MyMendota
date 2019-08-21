if(!exists("INAPP")){
  cat("[Info] secchi_overlay_years.R sourced for troubleshooting.\nMake sure to load data and packages from app.R first.\n")
  input <- list(NULL)
  input$chosen.year <- "2014"
} #else {
#  cat("[Info] secchi_moving.R called by shiny app.\n")
#}

sub.secchi<-subset(secchi, secchi$Year == input$chosen.year)

# Get data for secchi:
my.date <- parse_date_time(x = paste(input$slider.day, input$chosen.year), orders = "mdy")
index <- which(secchi$sample.date == my.date)
my.secchi <- secchi[index, ]
my.secchi$sample.date <- as.Date(my.secchi$sample.date)

sub.secchi$sample.date <- as.Date(sub.secchi$sample.date)

## Draw a plot from 0m to 20m for the secchi depth of that year
p.individual.date <-ggplot(data=sub.secchi, aes(x=sample.date, y=neg.depth, group=Year)) +
  geom_line() +
  geom_point() +
  #xlim(min(sub.secchi$yday),max(sub.secchi$yday)) +
  ylim(-20,0) +
  ylab("Depth(m)")+
  xlab("Day of Year") +
  geom_line(data = sub.secchi, aes(x=sample.date, y=neg.depth),colour="lightblue")+
  geom_area(data = sub.secchi, aes(x=sample.date, y=neg.depth), fill="lightblue", alpha=1)+
  geom_point(data = sub.secchi, aes(x=sample.date, y=neg.depth), col="lightblue")+
  # Background colours:
  theme(panel.background = element_rect(fill = "darkblue",
                                        colour = "darkblue",
                                        size = 0.5, linetype = "solid"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank())+
  ggtitle(paste("Secchi disk measurements in",input$chosen.year))+
  scale_x_date(date_labels = "%b", date_breaks = "1 month")

if (dim(my.secchi)[1] != 0) {
  my.secchi$image <- "www/secchi.png"
  p.individual.date <- p.individual.date + geom_image(data = my.secchi, aes(image=image),asp = 1.90, size=0.025)
}

print(p.individual.date)
