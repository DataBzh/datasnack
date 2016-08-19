library(readr)
library(ggplot2)
stmalo <- read_csv2("https://www.data.gouv.fr/s/resources/nombre-annuel-de-mariages-a-saint-malo/community/20150106-092109/35288-STMALO-Mariages.csv")
names(stmalo)[1] <- "Date"
names(stmalo)[2] <- "Volume"
ggplot(stmalo, aes(x = Date, y = Volume)) + 
  geom_bar(stat = "identity", fill ="#973232") + 
  geom_smooth(se = FALSE) + 
  xlab("Année") + 
  ylab("Volume") + 
  ggtitle("Mariages à Saint-Malo") +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=15),
        title=element_text(size=18),
        plot.title=element_text(margin=margin(0,0,20,0), size=18),
        axis.title.x=element_text(margin=margin(20,0,0,0)),
        axis.title.y=element_text(margin=margin(0,20,0,0)),
        legend.text=element_text(size = 12),
        plot.margin=margin(20,20,20,20), 
        panel.background = element_rect(fill = "white"), 
        panel.grid.major = element_line(colour = "grey")) 
