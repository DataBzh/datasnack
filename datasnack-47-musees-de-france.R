library(tidyverse)
library(rgdal)
bret <- read_csv2("https://data.culturecommunication.gouv.fr/explore/dataset/liste-et-localisation-des-musees-de-france/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true") %>%
  filter(NOMREG == "BRETAGNE") %>%
  separate("coordonnees_finales", into = c("lon","lat"), sep = ",")
table(bret$NOMDEP)
wmap_df <- readOGR(dsn=".", layer="R53_dep") %>%
  fortify()
ggplot(wmap_df, aes(long,lat, group=group)) + 
  geom_polygon() + 
  coord_map() +
  geom_path(data=wmap_df, aes(long, lat, group=group, fill=NULL), color="grey50") +
  geom_point(data = bret, aes(x = as.numeric(lat), y = as.numeric(lon), group = NULL, col = NOMDEP),size = 4) + 
  scale_color_manual(values = palette, name = "") +
  labs(title = "Les Musées de France en Bretagne", 
       caption = "http://data-bzh.fr") + 
  theme(title=element_text(),
        plot.title=element_text(margin=margin(0,0,20,0), size=30, hjust = 0.5),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        panel.grid.major= element_line("grey50", linetype = "dashed"), 
        panel.background= element_blank()) 
