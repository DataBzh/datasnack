elec <- read.csv2("http://bretagne.territoires.opendatasoft.com/explore/dataset/production-par-filiere-2008-a-2015/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true", stringsAsFactors = FALSE)
bret <- dplyr::filter(elec, Région == "Bretagne")
bret[3:8] <- sapply(bret[3:8], as.numeric)
summary(bret)
bret <- tidyr::gather(bret, Type, Volume, 3:8, na.rm = TRUE)
bret$Type <- gsub("[.]", " ", bret$Type)
bret$Type <- gsub("  GWh", " ", bret$Type)
library(ggplot2)
ggplot(bret, aes(x = Année, y = as.numeric(Volume), fill = Type, group = Type)) + 
  geom_bar(stat = "identity", position = "dodge") + 
  scale_fill_manual(values = c("#973232", "#1E5B5B", "#6D8D2F", "#287928", "#E18C8C", "#548787")) +
  ggtitle("Production régionale d'électricité annuelle par filière (2008 à 2015)") +
  xlab("Année") + 
  ylab("Production en GWh") +
  theme(title=element_text(size=18),
        plot.title=element_text(margin=margin(0,0,20,0), size=18),
        axis.title.x=element_text(margin=margin(20,0,0,0)),
        axis.title.y=element_text(margin=margin(0,20,0,0)),
        legend.text=element_text(size = 12),
        plot.margin=margin(20,20,20,20), 
        panel.background = element_rect(fill = "white"), 
        panel.grid.major = element_line(colour = "grey")) 
