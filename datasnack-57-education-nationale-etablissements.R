library(tidyverse)
source("data-bzh-tools-master/main.R")
educ <- read_csv2("https://data.education.gouv.fr/explore/dataset/fr-en-annuaire-education/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true")%>%
  filter(Code_region == 53) 

educ %>%
  group_by(Code_departement) %>%
  summarize(n())

table(educ$`Type établissement`)
educ$Statut_public_prive <- gsub("-", "Orientation/Information", educ$Statut_public_prive)

educ %>% 
  ggplot(aes(Code_departement, fill = `Type établissement`)) +
  geom_bar(position = "dodge") + 
  facet_wrap(~ Statut_public_prive) + 
  scale_fill_manual(values = databzh$colours) + 
  labs(title = "Établissements de l'éducation nationale en Bretagne", 
       subtitle = "Données via : Éducation nationale Open Data", 
       caption = "http://data-bzh.fr") + 
  databzhTheme()
