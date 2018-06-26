library(tidyverse)
library(lubridate)
source("../territoire/data-bzh-tools-master/main.R")
stat <- read.csv2("https://data.stmalo-agglomeration.fr/explore/dataset/grandes-marees-a-saint-malo/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true", stringsAsFactors = FALSE)

stat %>% 
  mutate(DATE = ymd(DATE), 
         AN = year(DATE), 
         MOIS = month(DATE)) %>%
  group_by(AN, MOIS) %>%
  summarise(MAREE = n()) %>%
  ggplot() +
  aes(as.factor(MOIS), MAREE) +
  geom_col(fill = databzh$colour1) +
  labs(title = "Mois d'apparition des grandes marées à Saint Malo \n2014 - 2018", 
       subtitle = "données via Saint Malo Open Data", 
       caption = "http://data-bzh.fr", 
       x = "Mois de l'année", 
       y = "Nombre de grandes marées") + 
  databzhTheme()

stat %>% 
  mutate(DATE = ymd(DATE), 
         AN = year(DATE), 
         MOIS = month(DATE)) %>%
  group_by(MOIS) %>%
  summarise(MAREES = n()) %>%
  knitr::kable(format = "html", align = "c") %>%
  clipr::write_clip()

stat %>% 
  ggplot() +
  aes(as.factor(JOUR)) +
  geom_bar(fill = databzh$colour2) +
  labs(title = "Jour d'apparition des grandes marées à Saint Malo \n2014 - 2018", 
       subtitle = "données via Saint Malo Open Data", 
       caption = "http://data-bzh.fr", 
       x = "Jour de l'année", 
       y = "Nombre de grandes marées") + 
  databzhTheme()

stat %>% 
  count(JOUR) %>%
  rename(Volume = n) %>%
  knitr::kable(format = "html", align = "c") %>%
  clipr::write_clip()


