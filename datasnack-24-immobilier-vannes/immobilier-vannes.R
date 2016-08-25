library(magrittr)
library(ggplot2)
vannes <- readr::read_csv("http://www.lesclesdumidi.com/csv_graph/56000.csv")
vannes$Période <- paste0("01 ", vannes$Période) %>%
  lubridate::dmy() 
sum(vannes$`Prix au m² des maisons` < vannes$`Prix au m² des appartements`)

vannes <- tidyr::gather(vannes, Type, Montant, 2:5)
ggplot(subset(vannes, vannes$Type == "Prix au m² des appartements" | vannes$Type == "Prix au m² des maisons"), aes(x = Période, y = Montant, group = Type, color = Type)) + 
  geom_line(size = 2) + 
  scale_color_manual(values = c("#973232", "#1E5B5B")) + 
  geom_smooth(mapping = aes(x = Période, y = Montant, group = Type), data = subset(vannes, vannes$Type == "Prix au m² des appartements" | vannes$Type == "Prix au m² des maisons"), inherit.aes = FALSE, se = FALSE) +
  xlab("Période") + 
  ylab(" ") + 
  ggtitle("Prix de l'immobilier à Vannes") +
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
