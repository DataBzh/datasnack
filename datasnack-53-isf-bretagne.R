library(tidyverse)
source("data-bzh-tools-master/main.R")

impots <- readxl::read_excel("/home/Téléchargements/isf2015_fd_8010.xls", sheet = 3, skip = 1) %>%
  filter(Région == "BRETAGNE")
summary(impots)
ggplot(impots, aes(x = `patrimoine moyen en €`, y = `impôt moyen en €`, col = Départements, lables = Commune)) +
  geom_label(aes(label = Commune)) + 
  scale_color_manual(values = databzh$colours) + 
  xlim(c(2200000,2850000)) +
  ylim(c(6500,11000)) +
  labs(title = "Impôt de solidarité sur la fortune en Bretagne en 2015", 
       subtitle = "Données via OpenData.gouv", 
       cation = "http://data-bzh.fr") +
  databzhTheme()
