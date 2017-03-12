source("data-bzh-tools-master/main.R")
library(tidyverse)
data.frame(date = c("2016-01-01", 
                    "2016-02-01",
                    "2016-03-01",
                    "2016-04-01",
                    "2016-05-01",
                    "2016-06-01",
                    "2016-07-01",
                    "2016-08-01",
                    "2016-09-01",
                    "2016-10-01",
                    "2016-11-01",
                    "2016-12-01"),
           visites = c(21,727,784,775,1398,938,860,851,1444,	
                       3136,3087,1805)
) %>%
  ggplot(aes(lubridate::ymd(date),visites)) +
  geom_bar(stat = "identity", fill = databzh$colour1) + 
  xlab(" ") +
  ylab(" ") +
  labs(title = "Visites sur Data Bzh en 2016", 
       subtitle = "Données via : DataBzh",
       caption = "http://data-bzh.fr") + 
  databzhTheme()

  
