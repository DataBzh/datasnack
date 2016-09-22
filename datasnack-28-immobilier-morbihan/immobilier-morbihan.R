library(ggplot2)
library(magrittr)
imm <- read.csv("http://www.lesclesdumidi.com/csv_graph/56.csv")
imm$Période <- paste0("01 ", imm$Période) %>%
  lubridate::dmy(.)
ggplot(imm, aes(x = Période, y = Prix.immobilier.au.m.)) + 
  geom_bar(stat = "identity", fill = "#973232") + 
  geom_smooth() + 
  xlab(" ") + 
  ylab("Prix de l'immobilier au m2") + 
  ggtitle("Le prix de l'immobilier dans le Morbihan, 2007-2016") + 
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
