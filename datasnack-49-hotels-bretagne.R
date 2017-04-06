library(tidyverse)
bret <- read_csv("Hotels de Bretagne.csv")
bret$CODEPOSTAL <- substr(bret$CODEPOSTAL, 1, 2)
ggplot(bret, aes(CLASSEMENT, fill = CODEPOSTAL)) +
  geom_bar() +
  scale_fill_manual(values = databzh$colours, name = "Département")+
  xlab(" ") +
  ylab("") +
  labs(title = "Classement des hôtels de Bretagne", 
       subtitle = "Données via : Data Tourisme Bretagne",
       caption = "http://data-bzh.fr") + 
  databzhTheme()

