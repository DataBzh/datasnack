library(tidyverse)
bret <- read_csv2("https://data.rennesmetropole.fr/explore/dataset/lst_agent_elus/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true")
source("../data-bzh-tools-master/main.R")

a <- bret %>% 
  count(APPARTENANCE, sort = TRUE) %>%
  ggplot() + 
  aes(reorder(APPARTENANCE, n), n) + 
  geom_col(fill = databzh$colour8) + 
  coord_flip() + 
  labs(title = "Appartenance des élus de la ville de Rennes", 
       substitle = "Données via Rennes Open Data", 
       x = "Appartenance", 
       y = "Volume", 
       caption = "http://data-bzh.fr") + 
  databzhTheme()

databzhSavePlot(a, "elus-rennes.png")

bret %>% 
  count(APPARTENANCE, sort = TRUE) %>% 
  knitr::kable(format = "html") %>% 
  clipr::write_clip()
