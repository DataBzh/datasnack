library(tidyverse)
gaz <- read.csv2("https://opendata.grtgaz.com/explore/dataset/conso-gaz-iris/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true")
bret <- gaz %>%
  filter(Région == "Bretagne")
bret$Annee <- as.Date(as.character(bret$Annee), "%Y")
bret$Consommation.industrie..MWh. <- as.numeric(as.character(bret$Consommation.industrie..MWh.))

ggplot(bret, aes(Annee, Consommation.industrie..MWh., fill = Département)) + 
  geom_bar(stat= 'identity', position = "dodge") + 
  scale_fill_manual(values = databzh$colours) + 
  scale_y_continuous(labels = scales::comma) +
  xlab("") +
  ylab("") +
  labs(title = "Consommation de gaz annuelle par maille IRIS (2008-2015)", 
       caption = "http://data-bzh.fr") + 
  databzhTheme()
