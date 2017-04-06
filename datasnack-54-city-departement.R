library(tidyverse)
source("data-bzh-tools-master/main.R")
bret <- read.csv("https://inspire.data.gouv.fr/api/geogw/services/556c602d330f1fcd483373ce/feature-types/ign:commune_053/download?format=CSV&projection=WGS84")
bret %>%
  ggplot(aes(DEPART, fill = STATUT)) + 
  geom_bar() + 
  scale_fill_manual(values = databzh$colours) + 
  xlab(" ") +
  ylab(" ") +
  labs(title = "Villes de Bretagne par département", 
       subtitle = "Données via Data Gouv",
       caption = "http://data-bzh.fr") +
  databzhTheme()
