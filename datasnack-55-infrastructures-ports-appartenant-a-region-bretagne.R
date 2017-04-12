library(tidyverse)
source("/home/colin/Dropbox/R/misc/data-bzh-tools-master/main.R")
bret <- jsonlite::fromJSON("https://inspire.data.gouv.fr/api/geogw/services/556c6042330f1fcd4833794d/feature-types/rb:infrastructure_port/download?format=GeoJSON&projection=WGS84", flatten = TRUE)
bret <- bret$features
bret$properties.theme <- gsub("Gestioi des eaux noires","Gestion des eaux noires", bret$properties.theme)
bret %>%
  group_by(properties.theme) %>%
  summarize(somme = n()) %>%
  ggplot(aes(reorder(properties.theme, somme), somme)) +
  geom_bar(stat = "identity", fill = databzh$colour1) +
  coord_flip() + 
  xlab("") + 
  ylab("") +
  labs(title = "Infrastructures des ports appartenant à la région Bretagne", 
       subtitle = "Données via Open Data gouv", 
       caption = "http://data-bzh.fr") + 
  databzhTheme()
  
