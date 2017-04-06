library(data.table)
library(magrittr)
library(ggplot2)
sport <- read.csv2("https://data.rennesmetropole.fr/explore/dataset/effectifs-pour-rennes-metropole-2014-2015/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true") %>%
  as.data.table()
sport <-sport[,.(Sum =sum(Total.général)),  by=DisciplineLib]
sport <- dplyr::arrange(sport, desc(Sum))
ggplot(sport[1:15,],aes(reorder(DisciplineLib,Sum), Sum)) + 
  geom_bar(stat="identity", fill = "#973232") + 
  coord_flip() + 
  xlab("") +
  ylab(" ") +
  labs(title = "Les 15 sports les plus pratiqués à Rennes sur la saison 2014-2015", 
       subtitle = "Données via : Open Data Rennes",
       caption = "http://data-bzh.fr") +
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
