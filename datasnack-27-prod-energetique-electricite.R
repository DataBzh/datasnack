library(tidyverse)
elec <- read_csv2("http://bretagne.territoires.opendatasoft.com/explore/dataset/production-par-filiere-2008-a-2015/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true")
bret <- dplyr::filter(elec, Région == "Bretagne")
bret[3:8] <- sapply(bret[3:8], as.numeric)
summary(bret)
bret <- tidyr::gather(bret, Type, Volume, 3:8, na.rm = TRUE)
bret$Type <- gsub("[.]", " ", bret$Type)
bret$Type <- gsub("  GWh", " ", bret$Type)
ggplot(bret, aes(x = Année, y = as.numeric(Volume), fill = Type, group = Type)) + 
  geom_bar(stat = "identity", position = "dodge") + 
  scale_fill_manual(values = c("#973232", "#1E5B5B", "#6D8D2F", "#287928", "#E18C8C", "#548787")) +
  ggtitle("Production régionale d'électricité annuelle par filière (2008 à 2015)") +
  xlab("Année") + 
  ylab("Production en GWh") +
  labs(caption = "http://data-bzh.fr")+
  databzhTheme()
