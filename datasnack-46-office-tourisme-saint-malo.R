library(tidyverse)
stma <- read_csv2("https://data.stmalo-agglomeration.fr/explore/dataset/frequentation-de-loffice-du-tourisme/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true")
stma <- stma %>%
  arrange(Année) %>%
  gather("Mois", "Volume", 2:13)
stma$Volume <- gsub(" ", "", stma$Volume) %>%
  as.numeric()
stma$Date <- stma$Mois %>%
  factor(level = c("janvier", "février","mars", "avril","mai","juin","juillet","août","septembre","octobre","novembre","décembre"))
palette <- c("#973232", "#1E5B5B", "#6D8D2F", "#287928", "#E18C8C", "#548787", "#B8D283", "#70B470", "#B75353", "#326E6E", "#8CAA4E", "#439243", "#711515", "#0D4444", "#4D6914", "#115A11", "#490101", "#012C2C", "#2E4401", "#013A01")
ggplot(stma, aes(Date, Volume, group = Année, col = as.factor(Année))) + 
  geom_line(size= 1.5) +
  scale_color_manual(values = palette, name = "Année") +
  xlab("Mois") +
  ylab("Volume de visites") +
  labs(title = "Fréquentation de l'Office du Tourisme de Saint-Malo", 
       subtitle = "Données via : Open Data Saint Malo",
       caption = "http://data-bzh.fr") + 
  databzhTheme()
