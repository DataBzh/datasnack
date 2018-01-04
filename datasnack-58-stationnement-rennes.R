library(tidyverse)
library(rgdal) 
source("../territoire/data-bzh-tools-master/main.R")
stat <- read.csv2("https://data.rennesmetropole.fr/explore/dataset/places-de-stationnement-reservees-rennes/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true", stringsAsFactors = FALSE)

stat %>% 
  group_by(TYPE) %>%
  summarise(`Nombre de places moyennes` = sum(NB_PLACES, na.rm = TRUE)) %>%
  ggplot() +
  aes(reorder(TYPE, `Nombre de places moyennes`), `Nombre de places moyennes`) + 
  geom_col(fill = databzh$colour4) +
  coord_flip() +
  labs(title = "Places de stationnement réservées sur la ville de Rennes", 
       subtitle = "données via Rennes Open Data", 
       caption = "http://data-bzh.fr", 
       x = "Nombre de places totales", 
       y = "Type de stationnement") + 
  databzhTheme()

stat %>% 
  group_by(TYPE) %>%
  summarise(`Nombre de places moyennes` = mean(NB_PLACES, na.rm = TRUE),
            `Nombre de places totales` = sum(NB_PLACES, na.rm = TRUE))  %>%
  arrange(desc(`Nombre de places moyennes`)) %>%
  knitr::kable(format = "html") %>%
  clipr::write_clip()
