library(readr)
library(dplyr)
fete <- read_csv2("http://datainfolocale.opendatasoft.com/explore/dataset/fetemusique2016_/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true")
bretagne <- filter(fete, Région == "Bretagne")

library(ggplot2)
palette <- c("#973232", "#1E5B5B", "#6D8D2F", "#287928")

ggplot(bretagne, aes(`Première date`, fill = Département)) + 
  geom_bar(stat = "count", position = "dodge") + 
  scale_fill_manual(values = palette) +
  xlab("Jour") + 
  ylab("Nombre de concerts") + 
  ggtitle("Fête de la musique 2016 en Bretagne") +
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
