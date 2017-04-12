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
  labs(caption = "http://data-bzh.fr") +
  databzhTheme()