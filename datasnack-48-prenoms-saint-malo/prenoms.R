library(tidyverse)
stma <- read_csv2("https://data.stmalo-agglomeration.fr/explore/dataset/prenoms-donnes-aux-enfants-nes-a-saint-malo/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true")
stma <- stma %>%
  group_by(Année) %>%
  arrange(desc(`Nombre de naissances`)) %>% 
  summarise(first = first(Prénom), 
            vol = first(`Nombre de naissances`)) %>%
  ungroup() %>%
  ggplot(aes(Année, vol)) + 
  geom_bar(stat = "identity", fill = prénom) +
  scale_x_continuous(breaks = seq(1994,2016,by=2)) +
  geom_label(aes(label = first), size = 3) +
  coord_flip() +
  xlab(" ") +
  ylab("Prénoms") +
  labs(title = "Prénoms les plus donnés à Saint-Malo", 
       subtitle = "Données via : Open Data Saint-Malo",
       caption = "http://data-bzh.fr") + 
  databzhTheme()

