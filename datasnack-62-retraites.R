library(tidyverse)
bret <- read_csv2("https://data.cnav.fr/explore/dataset/nombre-de-retraites-par-carsat-au-31-decembre/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true")
source("../data-bzh-tools-master/main.R")
bret <- bret %>% filter(Carsat == "Rennes")
a <- bret %>% 
  arrange(Années) %>% 
  ggplot(aes(Années, Effectif)) +
  geom_col(fill = databzh$colours[9]) + 
  labs(title = "Évolution des Effectifs, Carsat de Rennes", 
       substitle = "Données via Open Data de l'assurance retraite", 
       x = "Années", 
       y = "Volume", 
       caption = "http://data-bzh.fr") + 
  databzhTheme()

databzhSavePlot(a, "carsat-retraite-rennes.png")

bret %>% 
  arrange(Années) %>%
  knitr::kable(format = "html") %>% 
  clipr::write_clip()
