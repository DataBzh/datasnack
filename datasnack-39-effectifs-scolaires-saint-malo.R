library(ggplot2)
library(data.table)
library(magrittr)
source("data-bzh-tools-master/main.R")
ecole <- read.csv2("effectifs-scolaires.csv")%>%
  as.data.table()
ecole <- ecole[, sum(TOTAL.par.école), by = .(Type, Année)]
databzhPlot(ggplot(ecole, aes(Année, V1, fill = Type)) + 
  geom_bar(stat = "identity", position = "dodge") + 
  ylim(c(0,2800)) +
  scale_fill_manual(values = databzh$colours) + 
  xlab("") +
  ylab(" ") +
  labs(title = "Effectifs scolaires de Saint-Malo, 2011-2016", 
       caption = "http://data-bzh.fr") + 
  databzhTheme())
