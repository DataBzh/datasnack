library(tidyverse)
library(rgdal) 
jdl <- read.csv2("/home/colin/Dropbox/R/misc/journal-des-lycees.csv")
jdl <- jdl %>% 
  filter(grepl(("^22|^29|^35|^56"), Code.Postal)) %>%
  tidyr::separate(Position, into = c("lon", "lat"), sep = ",")
roj <- readOGR(dsn=".", layer="R53_dep")
wmap_df <- fortify(roj)
ggplot(wmap_df, aes(long,lat, group=group)) + 
  geom_polygon() + 
  coord_map() +
  geom_path(data=wmap_df, aes(long, lat, group=group, fill=NULL), color="grey50") +
  geom_point(data = jdl, aes(x = as.numeric(lat), y = as.numeric(lon), group = NULL, col = Type),size = 4) + 
  scale_color_manual(values = palette) + 
  labs(title = "Les journaux du lycée en Bretagne", 
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
